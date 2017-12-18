import UIKit
import CoreGraphics

/**
 Type definition for a function that will receive updates from the JoyStickView when the handle moves. Takes two
 values, both CGFloats.
 - parameter angle: the direction the handle is pointing. Unit is degrees with 0° pointing up (north), and 90° pointing
 right (east).
 - parameter displacement: how far from the view center the joystick is moved in the above direction. Unitless but
 is the ratio of distance moved from center over the radius of the joystick base. Always in range 0.0-1.0
 */
public typealias JoyStickViewMonitor = (_ angle: CGFloat, _ displacement: CGFloat) -> ()

/**
 A simple implementation of a joystick interface like those found on classic arcade games. This implementation detects
 and reports two values when the joystick moves:
 
 * angle: the direction the handle is pointing. Unit is degrees with 0° pointing up (north), and 90° pointing
 right (east).
 * displacement: how far from the view center the joystick is moved in the above direction. Unitless but
 is the ratio of distance moved from center over the radius of the joystick base. Always in range 0.0-1.0
 
 The view has two settable parameters:
 
 * monitor: a function of type `JoyStickViewMonitor` that will receive updates when the joystick's angle and/or
 displacement values change.
 * movable: a boolean that when true lets the joystick move around in its parent's view when there joystick moves
 beyond displacement of 1.0.
 
 */
public final class JoyStickView: UIView {
    
    /// Holds a function to call when joystick orientation changes
    public var monitor: JoyStickViewMonitor? = nil
    
    /// The opacity of the base of the joystick. Note that this is different than the view's overall opacity setting.
    /// The end result will be a base image with an opacity of `baseAlpha` * `view.alpha`
    public var baseAlpha: CGFloat {
        get {
            return baseImageView.alpha
        }
        set {
            baseImageView.alpha = newValue
        }
    }
    
    /// The tintColor to apply to the handle. By default, uses the view's tintColor value. Changing it while joystick
    /// is visible will update the handle image.
    public var handleTintColor: UIColor! {
        didSet { makeHandleImage() }
    }
    
    /// The last-reported angle from the joystick handle. Unit is degrees, with 0° up (north) and 90° right (east)
    public private(set) var angle: CGFloat = 0.0
    
    /// The last-reported displacement from the joystick handle. Dimensionless but is the ratio of movement over
    /// the radius of the joystick base. Always falls between 0.0 and 1.0
    public private(set) var displacement: CGFloat = 0.0
    
    /// The radius of the base of the joystick, the max distance the handle may move in any direction.
    private lazy var radius: CGFloat = { return self.bounds.size.width / 2.0 }()
    
    /// The image to use for the base of the joystick
    private let baseImage = UIImage(named: "game_btn_touch_pad_icon")!
    
    /// The image to use for the joystick handle
    private let handleImage = UIImage(named: "game_btn_touch_dot_icon")!
    
    /// The image to use to show the base of the joystick
    private var baseImageView: UIImageView!
    
    /// The image to use to show the handle of the joystick
    private var handleImageView: UIImageView!
    
    /// Cache of the last joystick angle in radians
    private var lastAngleRadians: Float = 0.0
    
    /// The original location of the joystick. Used to restore its position when user double-taps on it.
    private var originalCenter: CGPoint?
    
    /// Tap gesture recognizer for double-taps which will reset the joystick position
    private var tapGestureRecognizer: UITapGestureRecognizer!
    
    /**
     Initialize new joystick view using the given frame.
     - parameter frame: the location and size of the joystick
     */
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    /**
     Initialize new joystick view from a file.
     - parameter coder: the source of the joystick configuration information
     */
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    /**
     Common initialization of view. Creates UIImageView instances for base and handle.
     */
    private func initialize() {
        
        handleTintColor = tintColor
        
        baseImageView = UIImageView(image: baseImage)
        baseImageView.alpha = baseAlpha
        baseImageView.contentMode = .scaleAspectFit
        addSubview(baseImageView)
        
        handleImageView = UIImageView(image: handleImage)
        handleImageView.contentMode = .scaleAspectFit
        makeHandleImage()
        addSubview(handleImageView)
        
        baseImageView.snp.remakeConstraints { (make) in
            make.leading.equalTo(snp.leading)
            make.bottom.equalTo(snp.bottom)
            make.top.equalTo(snp.top)
            make.trailing.equalTo(snp.trailing)
        }
        
        handleImageView.snp.remakeConstraints { (make) in
            make.leading.equalTo(snp.leading)
            make.bottom.equalTo(snp.bottom)
            make.top.equalTo(snp.top)
            make.trailing.equalTo(snp.trailing)
        }
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resetFrame))
        tapGestureRecognizer!.numberOfTapsRequired = 2
        addGestureRecognizer(tapGestureRecognizer!)
    }
    
    /**
     Generate a new handle image using the current `tintColor` value and install. Uses CoreImage filter to apply a 
     tint to the grey handle image.
     */
    private func makeHandleImage() {
        guard handleImageView != nil else { return }
        guard let inputImage = CIImage(image: handleImage) else {
            fatalError("failed to create input CIImage")
        }
        
        let filterConfig: [String:Any] = [kCIInputIntensityKey: 1.0,
                                          kCIInputColorKey: CIColor(color: handleTintColor!),
                                          kCIInputImageKey: inputImage]
        guard let filter = CIFilter(name: "CIColorMonochrome", withInputParameters: filterConfig) else {
            fatalError("failed to create CIFilter CIColorMonochrome")
        }
        
        guard let outputImage = filter.outputImage else {
            fatalError("failed to obtain output CIImage")
        }
        
        handleImageView.image = UIImage(ciImage: outputImage)
    }
    
    /**
     A touch began in the joystick view
     - parameter touches: the set of UITouch instances, one for each touch event
     - parameter event: additional event info (ignored)
     */
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        updatePosition(touch: touch)
    }
    
    /**
     An existing touch has moved.
     - parameter touches: the set of UITouch instances, one for each touch event
     - parameter event: additional event info (ignored)
     */
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        updatePosition(touch: touch)
    }
    
    /**
     An existing touch event has been cancelled (probably due to system event such as an alert). Move joystick to
     center of base.
     - parameter touches: the set of UITouch instances, one for each touch event (ignored)
     - parameter event: additional event info (ignored)
     */
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetPosition()
    }
    
    /**
     User removed touch from display. Move joystick to center of base.
     - parameter touches: the set of UITouch instances, one for each touch event (ignored)
     - parameter event: additional event info (ignored)
     */
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetPosition()
    }
    
    /**
     Reset our position.
     */
    @objc public func resetFrame() {
        if displacement < 0.5 && originalCenter != nil {
            center = originalCenter!
            originalCenter = nil
        }
    }
    
    /**
     Reset handle position so that it is in the center of the base.
     */
    private func resetPosition() {
        updateLocation(location: CGPoint(x: frame.midX, y: frame.midY))
    }
    
    /**
     Update the handle position based on the current touch location.
     - parameter touch: the UITouch instance describing where the finger/pencil is
     */
    private func updatePosition(touch: UITouch) {
        updateLocation(location: touch.location(in: superview!))
    }
    
    /**
     Update the location of the joystick based on the given touch location. Resulting behavior depends on `movable`
     setting.
     - parameter location: the current handle position. NOTE: in coordinates of the superview
     */
    private func updateLocation(location: CGPoint) {
        guard let superview = self.superview else { return }
        guard superview.bounds.contains(location) else { return }
        
        // Calculate displacements between given location and our frame's center
        //
        let delta = location - frame.mid
        
        // Calculate normalized displacement
        //
        let normalizedDisplacement = delta.magnitude / radius
        
        // Calculate pointing angle used displacements. NOTE: using this ordering of dx, dy to atan2f to obtain
        // navigation angles where 0 is at top of clock dial and angle values increase in a clock-wise direction.
        //
        let newAngleRadians = atan2f(Float(delta.dx), Float(delta.dy))
        
        if normalizedDisplacement > 1.0 {
            
            // Keep handle on the circumference of the base image
            //
            let x = CGFloat(sinf(newAngleRadians)) * radius
            let y = CGFloat(cosf(newAngleRadians)) * radius
            handleImageView.frame.origin = CGPoint(x: x + bounds.midX - handleImageView.bounds.size.width / 2.0,
                                                   y: y + bounds.midY - handleImageView.bounds.size.height / 2.0)
        }
        else {
            handleImageView.center = bounds.mid + delta
        }
        
        // Update joystick reporting values
        //
        let newClampedDisplacement = min(normalizedDisplacement, 1.0)
        if newClampedDisplacement != displacement || newAngleRadians != lastAngleRadians {
            displacement = newClampedDisplacement
            lastAngleRadians = newAngleRadians
            
            // Convert to degrees: 0° is up, 90° is right, 180° is down and 270° is left
            //
            self.angle = newClampedDisplacement != 0.0 ? CGFloat(180.0 - newAngleRadians * 180.0 / Float.pi) : 0.0
            monitor?(angle, displacement)
        }
    }
}
