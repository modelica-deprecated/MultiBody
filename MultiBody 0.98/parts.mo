package Parts
  "Rigid components such as bodies with mass and inertia and massless rods"

  import SI = Modelica.SIunits;
  extends Modelica.Icons.Library;

  annotation (preferedView="info", Documentation(info="<HTML>
<p>
Package <b>Parts</b> contains <b>rigid components</b> of a
multi-body system. These components may be used to build up
more complicated structures. For example, a part may be built up of
a \"Body\" and of several \"FixedTranslation\" components.
<p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Model</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td><b>Fixed</b></td>
      <td>Frame fixed in world frame at a given position.
          It is visualized with a shape, see <b>shapeType</b> below
         (the frames on the two
          sides do not belong to the component):<br>&nbsp;<br>
      <IMG SRC=\"../Images/Fixed.png\" ALT=\"model Parts.Fixed\">
      </td>
  </tr>
  <tr><td><b>FixedTranslation</b></td>
      <td>Fixed translation of frame_b with respect to frame_a.
          It is visualized with a shape, see <b>shapeType</b> below
          (the frames on the two sides do not belong to the component):<br>&nbsp;<br>
      <IMG SRC=\"../Images/FixedTranslation.png\" ALT=\"model Parts.FixedTranslation\">
      </td>
  </tr>
  <tr><td><b>FixedRotation</b></td>
      <td>Fixed translation and fixed rotation of frame_b with respect to frame_a
          It is visualized with a shape, see <b>shapeType</b>  below
          (the frames on the two sides do not belong to the component):<br>&nbsp;<br>
      <IMG SRC=\"../Images/FixedRotation.png\" ALT=\"model Parts.FixedRotation\">
      </td>
  </tr>
  <tr><td><b>Body</b></td>
      <td>Rigid body with mass, inertia tensor and one frame connector.
          It is visualized with a cylinder and a sphere at the
          center of mass:<br>&nbsp;<br>
      <IMG SRC=\"../Images/Body.png\" ALT=\"model Parts.Body\">
      </td>
  </tr>
  <tr><td><b>BodyShape</b></td>
      <td>Rigid body with mass, inertia tensor, different shapes
          (see <b>shapeType</b> below)
          for animation, and two frame connectors:<br>&nbsp;<br>
      <IMG SRC=\"../Images/BodyShape.png\" ALT=\"model Parts.BodyShape\">
      </td>
  </tr>
  <tr><td><b>BodyBox</b></td>
      <td>Rigid body with box shape (mass and animation properties are computed
          from box data and from density):<br>&nbsp;<br>
      <IMG SRC=\"../Images/BodyBox.png\" ALT=\"model Parts.BodyBox\">
      </td>
  </tr>
  <tr><td><b>BodyCylinder</b></td>
      <td>Rigid body with cylinder shape (mass and animation properties
          are computed from cylinder data and from density):<br>&nbsp;<br>
      <IMG SRC=\"../Images/BodyCylinder.png\" ALT=\"model Parts.BodyCylinder\">
      </td>
  </tr>
</table>
<p>
Components <b>Fixed</b>, <b>FixedTranslation</b>, <b>FixedRotation</b>
and <b>BodyShape</b> are visualized according to parameter
<b>shapeType</b>, that may have the following values (e.g., shapeType = \"box\"): <br>&nbsp;<br>
</p>
<IMG SRC=\"../Images/FixedShape.png\" ALT=\"model Visualizers.FixedShape\">
<p>
Colors in all animation parts are defined via parameter <b>color</b>.
This is an Integer vector with 3 elements, {r, g, b}, and specifies the
color of the shape. {r,g,b} are the \"red\", \"green\" and \"blue\" color parts,
given in the ranges 0 .. 255, respectively. The predefined type
<b>MultiBody.Types.Color</b> contains a menu
definition of the colors used in the MultiBody library
(this will be replaced by a color editor).
</p>
</HTML>
"));

  model Fixed "Frame fixed in the world frame at a given position"
    import SI = Modelica.SIunits;
    Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);

    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.Position r[3]={0,0,0}
      "Position vector from world frame to frame_b, resolved in world frame";
    parameter MultiBody.Types.ShapeType shapeType="cylinder"
      "|Animation|if animation = true| Type of shape";
    parameter SI.Position r_shape[3]={0,0,0}
      "|Animation|if animation = true| Vector from world frame to shape origin, resolved in world frame";
    parameter SI.Position lengthDirection[3]=r - r_shape
      "|Animation|if animation = true| Vector in length direction of shape, resolved in world frame";
    parameter SI.Position widthDirection[3]={0,1,0}
      "|Animation|if animation = true| Vector in width direction of shape, resolved in world frame";
    parameter SI.Length length=Frames.length(r - r_shape)
      "|Animation|if animation = true| Length of shape";
    parameter SI.Distance width=length/world.defaultWidthFraction
      "|Animation|if animation = true| Width of shape";
    parameter SI.Distance height=width
      "|Animation|if animation = true| Height of shape";
    parameter Real extra=0.0
      "|Animation|if animation = true| Additional parameter for cone, pipe etc. (see docu of Visualizers.Advanced.Shape)";
    parameter MultiBody.Types.Color color=MultiBody.Types.Defaults.RodColor
      "|Animation|if animation = true| Color of shape";

    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.27,
        y=0.02,
        width=0.63,
        height=0.73),
      Icon(
        Rectangle(extent=[-90, 90; 90, -90], style(color=7, fillColor=7)),
        Text(extent=[150, 170; -142, 106], string="%name"),
        Line(points=[0, 100; 0, -100], style(color=0)),
        Line(points=[0, -80; -100, -20], style(color=0)),
        Line(points=[0, -40; -100, 20], style(color=0)),
        Line(points=[0, 0; -100, 60], style(color=0)),
        Line(points=[0, 40; -100, 100], style(color=0)),
        Line(points=[0, 0; 100, 0], style(color=0)),
        Text(
          extent=[-146, -104; 154, -148],
          string="r=%r",
          style(color=0))),
      Documentation(info="<html>
<p>
Element consisting of a frame (frame_b) that is fixed in the world
frame at a given position defined by parameter vector <b>r</b>
(vector from origin of world frame to frame_b, resolved in the
world frame).
</p>
<p>
By default, this component is visualized by a cylinder connecting the
world frame and frame_b of this components, as shown in the figure below.
Note, that the visualized world frame on the left side and
Fixed.frame_b on the right side are not part of the
component animation and that the animation may be switched off via parameter
animation = <b>false</b>.
</p>
<IMG SRC=\"../Images/Fixed.png\" ALT=\"Parts.Fixed\">
</HTML>
"),
      Diagram(
        Line(points=[0, 100; 0, -100], style(color=0)),
        Line(points=[0, -80; -100, -20], style(color=0)),
        Line(points=[0, -40; -100, 20], style(color=0)),
        Line(points=[0, 0; -100, 60], style(color=0)),
        Line(points=[0, 40; -100, 100], style(color=0)),
        Line(points=[0, 0; 100, 0], style(color=0))));

  protected
    outer MultiBody.World world;
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    Visualizers.Advanced.Shape shape[ndim](
      each shapeType=shapeType,
      each color=color,
      each length=length,
      each width=width,
      each height=height,
      each lengthDirection=lengthDirection,
      each widthDirection=widthDirection,
      each extra=extra,
      each r_shape=r_shape,
      each r=zeros(3),
      each R=Frames.nullRotation());
  equation
    defineRoot(frame_b.R);
    frame_b.r_0 = r;
    frame_b.R = Frames.nullRotation();
  end Fixed;

  model FixedTranslation "Fixed translation of frame_b with respect to frame_a"


    import SI = Modelica.SIunits;
    Interfaces.Frame_a frame_a annotation (extent=[-120, -15; -100, 15]);
    Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);

    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.Position r[3]={0,0,0}
      "Vector from frame_a to frame_b resolved in frame_a";
    parameter MultiBody.Types.ShapeType shapeType="cylinder"
      "|Animation|if animation = true| Type of shape";
    parameter SI.Position r_shape[3]={0,0,0}
      "|Animation|if animation = true| Vector from frame_a to shape origin, resolved in frame_a";
    parameter MultiBody.Types.Axis lengthDirection=r - r_shape
      "|Animation|if animation = true| Vector in length direction of shape, resolved in frame_a"
      annotation (Evaluate=true);
    parameter MultiBody.Types.Axis widthDirection={0,1,0}
      "|Animation|if animation = true| Vector in width direction of shape, resolved in frame_a"
      annotation (Evaluate=true);
    parameter SI.Length length=Frames.length(r - r_shape)
      "|Animation|if animation = true| Length of shape";
    parameter SI.Distance width=length/world.defaultWidthFraction
      "|Animation|if animation = true| Width of shape";
    parameter SI.Distance height=width
      "|Animation|if animation = true| Height of shape.";
    parameter Real extra=0.0
      "|Animation|if animation = true| Additional parameter depending on shapeType (see docu of Visualizers.Advanced.Shape).";
    parameter MultiBody.Types.Color color=MultiBody.Types.Defaults.RodColor
      "|Animation|if animation = true| Color of shape";

    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.25,
        y=0.04,
        width=0.67,
        height=0.69),
      Icon(
        Rectangle(extent=[-100, 5; 100, -5], style(color=0, fillColor=0)),
        Text(extent=[-132, 97; 128, 37], string="%name"),
        Text(
          extent=[127, -72; -133, -22],
          string="%=r",
          style(color=0)),
        Text(
          extent=[-95, 34; -59, 9],
          style(color=10),
          string="a"),
        Text(
          extent=[62, 32; 98, 7],
          style(color=10),
          string="b")),
      Diagram(
        Rectangle(extent=[-100, 5; 100, -5], style(color=0, fillColor=0)),
        Line(points=[-95, 20; -58, 20], style(color=10, arrow=1)),
        Line(points=[-94, 18; -94, 50], style(color=10, arrow=1)),
        Text(
          extent=[-72, 35; -58, 24],
          string="x",
          style(color=10)),
        Text(
          extent=[-113, 57; -98, 45],
          string="y",
          style(color=10)),
        Line(points=[-100, -4; -100, -69], style(color=10)),
        Line(points=[-100, -63; 90, -63], style(color=10)),
        Text(
          extent=[-22, -39; 16, -63],
          string="r",
          style(color=10)),
        Polygon(points=[88, -59; 88, -68; 100, -63; 88, -59], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[100, -3; 100, -68], style(color=10)),
        Line(points=[69, 20; 106, 20], style(color=10, arrow=1)),
        Line(points=[70, 18; 70, 50], style(color=10, arrow=1)),
        Text(
          extent=[92, 35; 106, 24],
          string="x",
          style(color=10)),
        Text(
          extent=[51, 57; 66, 45],
          string="y",
          style(color=10))),
      Documentation(info="<HTML>
<p>
Component for a <b>fixed translation</b> of frame_b with respect
to frame_a, i.e., the relationship between connectors frame_a and frame_b
remains constant and frame_a is always <b>parallel</b> to frame_b.
</p>
<p>
By default, this component is visualized by a cylinder connecting
frame_a and frame_b, as shown in the figure below. Note, that the
two visualized frames are not part of the component animation and that
the animation may be switched off via parameter animation = <b>false</b>.
</p>
<IMG SRC=\"../Images/FixedTranslation.png\" ALT=\"Parts.FixedTranslation\">
</HTML>"));
  protected
    outer MultiBody.World world;
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    Visualizers.Advanced.Shape shape[ndim](
      each shapeType=shapeType,
      each color=color,
      each r_shape=r_shape,
      each lengthDirection=lengthDirection,
      each widthDirection=widthDirection,
      each length=length,
      each width=width,
      each height=height,
      each extra=extra,
      each r=frame_a.r_0,
      each R=frame_a.R);
  equation
    defineBranch(frame_a.R, frame_b.R);
    assert(cardinality(frame_a) > 0 or cardinality(frame_b) > 0,
      "Neither connector frame_a nor frame_b of FixedTranslation object is connected");

    frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, r);
    frame_b.R = frame_a.R;

    /* Force and torque balance */
    zeros(3) = frame_a.f + frame_b.f;
    zeros(3) = frame_a.t + frame_b.t + cross(r, frame_b.f);
  end FixedTranslation;

  model FixedRotation
    "Fixed translation and fixed rotation of frame_b with respect to frame_a"

    import SI = Modelica.SIunits;
    import Cv = Modelica.SIunits.Conversions;
    MultiBody.Interfaces.Frame_a frame_a
      annotation (extent=[-120, -15; -100, 15]);
    MultiBody.Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);

    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.Position r[3]={0,0,0}
      "Vector from frame_a to frame_b resolved in frame_a";
    parameter MultiBody.Types.RotationTypes.Temp rotationType=MultiBody.Types.
        RotationTypes.RotationAxis "Type of rotation description"
      annotation (Evaluate=true);
    parameter MultiBody.Types.Axis n={1,0,0}
      "|if rotationType = RotationAxis| Axis of rotation in frame_a (= same as in frame_b)"
      annotation (Evaluate=true);
    parameter Cv.NonSIunits.Angle_deg angle=0
      "|if rotationType = RotationAxis| Angle to rotate frame_a around axis n into frame_b";

    parameter MultiBody.Types.Axis n_x={1,0,0}
      "|if rotationType = TwoAxesVectors| Vector along x-axis of frame_b resolved in frame_a"
      annotation (Evaluate=true);
    parameter MultiBody.Types.Axis n_y={0,1,0}
      "|if rotationType = TwoAxesVectors| Vector along y-axis of frame_b resolved in frame_a"
      annotation (Evaluate=true);

    parameter MultiBody.Types.RotationSequence sequence(
      min={1,1,1},
      max={3,3,3}) = {1,2,3}
      "|if rotationType = PlanarRotationSequence| Sequence of rotations"
      annotation (Evaluate=true);
    parameter Cv.NonSIunits.Angle_deg angles[3]={0,0,0}
      "|if rotationType = PlanarRotationSequence| Rotation angles around the axes defined in 'sequence'";
    parameter MultiBody.Types.ShapeType shapeType="cylinder"
      "|Animation|if animation = true| Type of shape";
    parameter SI.Position r_shape[3]={0,0,0}
      "|Animation|if animation = true| Vector from frame_a to shape origin, resolved in frame_a";
    parameter MultiBody.Types.Axis lengthDirection=r - r_shape
      "|Animation|if animation = true| Vector in length direction of shape, resolved in frame_a"
      annotation (Evaluate=true);
    parameter MultiBody.Types.Axis widthDirection={0,1,0}
      "|Animation|if animation = true| Vector in width direction of shape, resolved in frame_a"
      annotation (Evaluate=true);
    parameter SI.Length length=MultiBody.Frames.length(r - r_shape)
      "|Animation|if animation = true| Length of shape";
    parameter SI.Distance width=length/world.defaultWidthFraction
      "|Animation|if animation = true| Width of shape";
    parameter SI.Distance height=width
      "|Animation|if animation = true| Height of shape.";
    parameter Real extra=0.0
      "|Animation|if animation = true| Additional parameter depending on shapeType (see docu of Visualizers.Advanced.Shape).";
    parameter MultiBody.Types.Color color=MultiBody.Types.Defaults.RodColor
      "|Animation|if animation = true| Color of shape";

    MultiBody.Frames.Orientation R_rel=if rotationType == 1 then
        MultiBody.Frames.planarRotation(MultiBody.Frames.normalize(n),
        Cv.from_deg(angle)) else if rotationType == 2 then
        MultiBody.Frames.from_nxy(n_x, n_y) else MultiBody.Frames.axesRotations(
        sequence, Cv.from_deg(angles))
      "Fixed relative orientation object to rotate from frame_a to frame_b";
    MultiBody.Frames.Orientation R_rel_inv=MultiBody.Frames.inverseRotation(
        R_rel) "Inverse of R_rel (rotate from frame_b to frame_a)";

  protected
    outer MultiBody.World world;
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    MultiBody.Visualizers.Advanced.Shape shape[ndim](
      each shapeType=shapeType,
      each color=color,
      each r_shape=r_shape,
      each lengthDirection=lengthDirection,
      each widthDirection=widthDirection,
      each length=length,
      each width=width,
      each height=height,
      each extra=extra,
      each r=frame_a.r_0,
      each R=frame_a.R);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.08,
        y=0.24,
        width=0.75,
        height=0.68),
      Documentation(info="<HTML>
<p>
Component for a <b>fixed translation</b> and <b>fixed rotation</b> of frame_b with respect
to frame_a, i.e., the relationship between connectors frame_a and frame_b
remains constant. There are several possibilities to define the
orientation of frame_b with respect to frame_a:
</p>
<ul>
<li><b>Planar rotation</b> along axis 'n' (that is fixed and resolved
    in frame_a) with a fixed angle 'angle'.</li>
<li><b>Vectors n_x</b> and <b>n_y</b> that are directed along the corresponding axes
    direction of frame_b and are resolved in frame_a (if n_y is not
    orthogonal to n_x, the y-axis of frame_b is selected such that it is
    orthogonal to n_x and in the plane of n_x and n_y).</li>
<li><b>Sequence</b> of <b>three planar axes rotations</b>.
    For example, \"sequence = {1,2,3}\" and \"angles = {90, 45, -90}\"
    means to rotate frame_a around the x axis with 90 degrees, around the new
    y axis with 45 degrees and around the new z axis around -90 degrees to
    arrive at frame_b. Note, that sequence={1,2,3}
    is the Cardan angle sequence and sequence = {3,1,3} is the Euler angle
    sequence.</li>
</ul>
<p>
By default, this component is visualized by a cylinder connecting
frame_a and frame_b, as shown in the figure below. In this figure
frame_b is rotated along the z-axis of frame_a with 60 degree. Note, that the
two visualized frames are not part of the component animation and that
the animation may be switched off via parameter animation = <b>false</b>.
</p>
<IMG SRC=\"../Images/FixedRotation.png\" ALT=\"Parts.FixedRotation\">
</HTML>", revisions="<HTML><p><b>Release Notes:</b></p>
<ul>
  <li><i>July 28, 2003</i><br>
         Bug fixed: if rotationType = PlanarRotationSequence, then 'angles'
         was used with unit [rad] instead of [deg].</li>
</ul>
</HTML>"),
      Icon(
        Text(extent=[-136, 79; 132, 139], string="%name"),
        Rectangle(extent=[-100, 5; 100, -4], style(color=0, fillColor=0)),
        Line(points=[80, 20; 129, 50], style(color=0)),
        Line(points=[80, 20; 57, 59], style(color=0)),
        Polygon(points=[144, 60; 117, 59; 132, 37; 144, 60], style(color=0,
              fillColor=0)),
        Polygon(points=[43, 80; 46, 50; 68, 65; 43, 80], style(color=0,
              fillColor=0)),
        Text(
          extent=[-144, -45; 143, -82],
          string="r=%r",
          style(color=0)),
        Text(
          extent=[-123, 38; -87, 13],
          style(color=10),
          string="a"),
        Text(
          extent=[88, -15; 124, -40],
          style(color=10),
          string="b")),
      Diagram(
        Line(points=[-100, -1; -100, -66], style(color=10)),
        Line(points=[100, 0; 100, -65], style(color=10)),
        Line(points=[-100, -60; 89, -60], style(color=10)),
        Text(
          extent=[-22, -36; 16, -60],
          string="r",
          style(color=10)),
        Rectangle(extent=[-100, 5; 100, -5], style(color=0, fillColor=0)),
        Line(points=[69, 29; 97, 45], style(color=10, arrow=1)),
        Line(points=[70, 27; 55, 54], style(color=10, arrow=1)),
        Text(
          extent=[95, 42; 109, 31],
          string="x",
          style(color=10)),
        Text(
          extent=[42, 70; 57, 58],
          string="y",
          style(color=10)),
        Line(points=[-95, 22; -58, 22], style(color=10, arrow=1)),
        Line(points=[-94, 20; -94, 52], style(color=10, arrow=1)),
        Text(
          extent=[-72, 37; -58, 26],
          string="x",
          style(color=10)),
        Text(
          extent=[-113, 59; -98, 47],
          string="y",
          style(color=10)),
        Polygon(points=[88, -56; 88, -65; 100, -60; 88, -56], style(
            color=0,
            fillColor=0,
            fillPattern=1))));
  equation

    defineBranch(frame_a.R, frame_b.R);
    assert(cardinality(frame_a) > 0 or cardinality(frame_b) > 0,
      "Neither connector frame_a nor frame_b of FixedRotation object is connected");

    /* Relationships between quantities of frame_a and frame_b */
    frame_b.r_0 = frame_a.r_0 + MultiBody.Frames.resolve1(frame_a.R, r);
    if rooted(frame_a.R) then
      frame_b.R = MultiBody.Frames.absoluteRotation(frame_a.R, R_rel);
      zeros(3) = frame_a.f + MultiBody.Frames.resolve1(R_rel, frame_b.f);
      zeros(3) = frame_a.t + MultiBody.Frames.resolve1(R_rel, frame_b.t) -
        cross(r, frame_a.f);
    else
      frame_a.R = MultiBody.Frames.absoluteRotation(frame_b.R, R_rel_inv);
      zeros(3) = frame_b.f + MultiBody.Frames.resolve1(R_rel_inv, frame_a.f);
      zeros(3) = frame_b.t + MultiBody.Frames.resolve1(R_rel_inv, frame_a.t) +
        cross(r, frame_b.f);
    end if;
  end FixedRotation;

  model Body
    "Rigid body with mass, inertia tensor and one frame connector (12 potential states)"


    import SI = Modelica.SIunits;
    import Cv = Modelica.SIunits.Conversions;
    import Modelica.Math.*;
    Interfaces.Frame_a frame_a(r_0(start=r_0_start), R(start=R_start))
      annotation (extent=[-120, -15; -100, 15]);

    parameter Boolean animation=true
      "= true, if animation shall be enabled (show cylinder and sphere)";
    parameter SI.Position r_CM[3]={0,0,0}
      "Vector from frame_a to center of mass, resolved in frame_a";
    parameter SI.Mass m=1 "Mass of rigid body";
    parameter SI.Inertia I_11=0.001
      "|Inertia tensor (resolved in center of mass, parallel to frame_a)| (1,1) element of inertia tensor";
    parameter SI.Inertia I_22=0.001
      "|Inertia tensor (resolved in center of mass, parallel to frame_a)| (2,2) element of inertia tensor";
    parameter SI.Inertia I_33=0.001
      "|Inertia tensor (resolved in center of mass, parallel to frame_a)| (3,3) element of inertia tensor";
    parameter SI.Inertia I_21=0
      "|Inertia tensor (resolved in center of mass, parallel to frame_a)| (2,1) element of inertia tensor";
    parameter SI.Inertia I_31=0
      "|Inertia tensor (resolved in center of mass, parallel to frame_a)| (3,1) element of inertia tensor";
    parameter SI.Inertia I_32=0
      "|Inertia tensor (resolved in center of mass, parallel to frame_a)| (3,2) element of inertia tensor";
    parameter Types.Init.Temp initType=Types.Init.Free
      "|Initialization|| Type of initialization (defines usage of start values below)";
    parameter SI.Position r_0_start[3]={0,0,0}
      "|Initialization|| Initial values of frame_a.r_0 (vector from origin of world frame to origin of frame_a resolved in world frame)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.RotationSequence sequence_start={1,2,3}
      "|Initialization|| Sequence of rotations to rotate world frame into frame_a at initial time"
      annotation (Evaluate=true);
    parameter Cv.NonSIunits.Angle_deg angles_start[3]={0,0,0}
      "|Initialization|| Initial values of angles to rotate world frame around 'sequence_start' axes into frame_a"
      annotation (Evaluate=false);
    parameter SI.Velocity v_0_start[3]={0,0,0}
      "|Initialization|| Initial values of velocity v_0 = der(frame_a.r_0)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.AngularVelocity_degs w_0_start[3]={0,0,0}
      "|Initialization|| Initial values of angular velocity of frame_a resolved in world frame"
      annotation (Evaluate=false);
    parameter SI.Acceleration a_0_start[3]={0,0,0}
      "|Initialization|| Initial values of acceleration a_0 = der(v_0)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.AngularAcceleration_degs2 z_0_start[3]={0,0,0}
      "|Initialization|| Initial values of angular acceleration z_0 = der(w_0)"
      annotation (Evaluate=false);
    parameter SI.Diameter sphereDiameter=world.defaultBodyDiameter
      "|Animation|if animation = true| Diameter of sphere";
    parameter MultiBody.Types.Color sphereColor=MultiBody.Types.Defaults.
        BodyColor "|Animation|if animation = true| Color of sphere";
    parameter SI.Diameter cylinderDiameter=sphereDiameter/MultiBody.Types.
        Defaults.BodyCylinderDiameterFraction
      "|Animation|if animation = true| Diameter of cylinder";
    parameter MultiBody.Types.Color cylinderColor=sphereColor
      "|Animation|if animation = true| Color of cylinder";
    parameter Boolean useQuaternions=true
      "|Advanced|| = true, if quaternions shall be utilized when body states are required, otherwise switch between sets of 3 Cardan angles";
    parameter Boolean enforceStates=false
      "|Advanced|| = true, if absolute variables of body object shall be used as states";
    final parameter SI.Inertia I[3, 3]=[I_11, I_21, I_31; I_21, I_22, I_32;
        I_31, I_32, I_33] "inertia tensor";
    final parameter Frames.Orientation R_start=MultiBody.Frames.axesRotations(
        sequence_start, Cv.from_deg(angles_start))
      "Orientation object from world frame to frame_a at initial time";

    final parameter SI.AngularVelocity w_a_start[3]=MultiBody.Frames.resolve2(
        R_start, w_0_start*Modelica.Constants.D2R);
    final parameter SI.AngularAcceleration z_a_start[3]=
        MultiBody.Frames.resolve2(R_start, z_0_start*Modelica.Constants.D2R);

    SI.Velocity v_0[3](start=v_0_start)
      "Absolute velocity of frame_a, resolved in world frame";
    SI.Acceleration a_0[3]
      "Absolute acceleration of frame_a resolved in world frame";
    SI.AngularVelocity w_a[3](start=w_a_start)
      "Absolute angular velocity of frame_a resolved in frame_a";
    SI.AngularAcceleration z_a[3]
      "Absolute angular acceleration of frame_a resolved in frame_a";
    SI.Acceleration g_0[3] "Gravity acceleration resolved in world frame";
    annotation (
      defaultAttributes={"inner"},
      defaultInstanceName="world",
      defaultModifiers="gravityType=0",
      missingInnerMessage="No \"world\" component is defined. A default world component
without a gravity field will be used. If this is not desired,
drag MultiBody.World into the top level of your model.",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.21,
        y=0,
        width=0.75,
        height=0.82),
      Icon(
        Rectangle(extent=[-100, 30; -3, -31], style(
            color=8,
            gradient=2,
            fillColor=69)),
        Text(
          extent=[131, -123; -129, -73],
          style(color=0),
          string="m=%m"),
        Text(extent=[-128, 132; 132, 72], string="%name"),
        Ellipse(extent=[-20, 60; 100, -60], style(gradient=3, fillColor=69))),
      Diagram,
      Documentation(info="<HTML>
<p>
<b>Rigid body</b> with mass and inertia tensor.
All parameter vectors have to be resolved in frame_a.
The <b>inertia tensor</b> has to be defined with respect to a
coordinate system that is parallel to frame_a with the
origin at the center of mass of the body.
</p>
<p>
By default, this component is visualized by a <b>cylinder</b> located
between frame_a and the center of mass and by a <b>sphere</b> that has
its center at the center of mass. If the cylinder length is smaller as
the radius of the sphere, e.g., since frame_a is located at the
center of mass, the cylinder is not displayed. Note, that
the animation may be switched off via parameter animation = <b>false</b>.
</p>
<IMG SRC=\"../Images/Body.png\" ALT=\"Parts.Body\">
<p>
Every body has potential states. If possible a tool will select
the states of joints and not the states of bodies because this is
usually the most efficient choice. In this case the position, orientation,
velocity and angular velocity of frame_a of the body will be computed
by the component that is connected to frame_a. However, if a body is moving
freely in space, the states of the body have to be used. The
states of the body are:
</p>
<ul>
<li> The <b>position vector</b> frame_a.r_0 from the origin of the
     world frame to the origin of frame_a of the body, resolved in
     the world frame.</li>
<li> <b>3 Cardan angles</b> to rotate along axis x of frame \"fix\"
     with angle phi[1], along axis y with angle phi[2] and
     finally along axis z with angle phi[3] arriving at frame_a.
     Frame \"<b>fix</b>\" is a coordinate system that is fixed relatively
     to the world frame. Whenever the Cardan angles come close to
     their singular configuration, frame \"fix\" is changed, such
     that the new Cardan angles are far away from their
     singularity, i.e., a singular configuration will never occur.
     The initial values of the Cardan angle states are automatically
     computed from the initial values given via the
     <b>sequence_start</b> and <b>angles_start</b> values.
     Since the Cardan angles are defined relatively to a frame fix that
     is changing during simulation, these variables are not very
     descriptive. It is better to use the orientation object frame_a.R
     to get information about the body orientation.</li>
<li> The <b>absolute velocity</b> v_0 of the origin of frame_a,
     resolved in the world frame (= der(frame_a.r_0)).</li>
<li> The <b>absolute angular velocity</b> w_a of frame_a with
     respect to the world frame, resolved in frame_a.</li>
</ul>
<p>
Alternatively, as body states <b>4 quaternions</b> can be used instead
of the 3 Cardan angles,
by setting parameter <b>useQuaternions</b> in the \"Advanced\" menu
to <b>true</b>. Quaternions do not have a singular configuration and
therefore no state events will occur during simulation, as it is
necessary for the Cardan angles to change the base frame \"fix\".
The disadvantage of quaternions is that there is a non-linear constraint
equation between the 4 quaternions. Therefore, at least one non-linear
equation has to be solved per body during simulation.
In most cases, the Cardan angle choice will be more efficient as the
quaternion choice, but there may be cases where quaternions are better
suited.
</p>
</HTML>"));

  protected
    outer MultiBody.World world;

    // Declarations for quaternions (dummies, if quaternions are not used)
    parameter Frames.Quaternions.Orientation Q_start=MultiBody.Frames.to_Q(
        R_start)
      "Quaternion orientation object from world frame to frame_a at initial time";
    Frames.Quaternions.Orientation Q(start=Q_start)
      "Quaternion orientation object from world frame to frame_a (dummy value, if quaternions are not used as states)";

    // Declarations for Cardan angles (dummies, if cardan angles are not used)
    constant Real phi2_critical=Modelica.SIunits.Conversions.from_deg(80)
      "Change frame base when this angle is reached to avoid Cardan angle singularity";
    constant Real c2_small=1.e-5
      "if cos(phi[2]) < c2_small then c2_small is used as guard against zero division";
    SI.Angle phi[3]
      "Dummy or cardan angles from frame_fixed (fixed in world) to frame_a of body";
    Real s1 "Dummy or sin(phi[1])";
    Real s2 "Dummy or sin(phi[2])";
    Real s3 "Dummy or sin(phi[3])";
    Real c1 "Dummy or cos(phi[1])";
    Real c2a "Dummy or cos(phi[2])";
    Real c2
      "Dummy or cos(phi[2]) (there is a guard, that c2 cannot be identical to zero)";
    Real c3 "Dummy or cos(phi[2])";
    SI.Angle phi_aux[3]
      "Dummy or phi = phi_aux + phi_reinit; der(phi) = der(phi_aux)";
    discrete SI.Angle phi_reinit[3](each fixed=true, each start=0)
      "Dummy or initial value at events near the singularity of phi, such that phi = 0 after the event";
    SI.AngularVelocity phi_d1 "Dummy or der(phi_d[1])";
    Real T_abs[3, 3](start=identity(3))
      "Dummy or absolute transformation matrix from world frame to frame_a of body";
    discrete Real T_fix[3, 3](start=identity(3))
      "Dummy or T_abs = f(phi)*T_fix";

    // Declarations for animation
    parameter Integer ndim1=if world.enableAnimation and animation and
        cylinderDiameter > 0 then 1 else 0;
    parameter Integer ndim2=if world.enableAnimation and animation and
        sphereDiameter > 0 then 1 else 0;
    Visualizers.Advanced.Shape cylinder[ndim1](
      each shapeType="cylinder",
      each color=cylinderColor,
      each length=if MultiBody.Frames.length(r_CM) > sphereDiameter/2 then
          MultiBody.Frames.length(r_CM) - (if cylinderDiameter > 1.1*
          sphereDiameter then sphereDiameter/2 else 0) else 0,
      each width=cylinderDiameter,
      each height=cylinderDiameter,
      each lengthDirection=r_CM,
      each widthDirection={0,1,0},
      each r=frame_a.r_0,
      each R=frame_a.R);
    Visualizers.Advanced.Shape sphere[ndim2](
      each shapeType="sphere",
      each color=sphereColor,
      each length=sphereDiameter,
      each width=sphereDiameter,
      each height=sphereDiameter,
      each lengthDirection={1,0,0},
      each widthDirection={0,1,0},
      each r_shape=r_CM - {1,0,0}*sphereDiameter/2,
      each r=frame_a.r_0,
      each R=frame_a.R);
    Real TT_fix[3, 3]=MultiBody.Frames.to_T(R_start);
  initial equation
    if initType == Types.Init.Position or initType == Types.Init.
        PositionVelocity or initType == Types.Init.PositionVelocityAcceleration then
      // Initialize positional variables
      frame_a.r_0 = r_0_start;
      if not isRoot(frame_a.R) then
        // use equality constraint of orientation object
        zeros(3) = Frames.Orientation.equalityConstraint(frame_a.R, R_start);
      elseif useQuaternions then
        // use quaternions
        zeros(3) = Frames.Quaternions.Orientation.equalityConstraint(Q, Q_start);
      else
        // use Cardan angles
        phi = Frames.axesRotationsAngles(R_start, {1,2,3});
      end if;
    end if;

    if initType == Types.Init.PositionVelocity or initType == Types.Init.
        PositionVelocityAcceleration or initType == Types.Init.Velocity or initType ==
        Types.Init.VelocityAcceleration then
      // Initialize velocity variables
      v_0 = v_0_start;
      w_a = w_a_start;
    end if;

    if initType == Types.Init.VelocityAcceleration or initType == Types.Init.
        PositionVelocityAcceleration then
      // Initialize acceleration variables
      a_0 = a_0_start;
      z_a = z_a_start;
    end if;

    if initType == Types.Init.SteadyState then
      v_0 = zeros(3);
      a_0 = zeros(3);
      w_a = zeros(3);
      z_a = zeros(3);
    end if;

    if isRoot(frame_a.R) and not useQuaternions then
      T_fix = Frames.to_T(R_start);
    else
      T_fix = identity(3);
    end if;
  equation
    if enforceStates then
      defineRoot(frame_a.R);
    else
      definePotentialRoot(frame_a.R);
    end if;

    // rotational kinematic differential equations -----------------------
    if not isRoot(frame_a.R) then


        // Body frame is computed somewhere else (variables from else branch are dummies)
      w_a = Frames.angularVelocity2(frame_a.R, der(frame_a.R));
      z_a = der(w_a);
      Q = Frames.Quaternions.nullRotation();
      s1 = 0;
      s2 = 0;
      s3 = 0;
      c1 = 0;
      c2 = 0;
      c2a = 0;
      c3 = 0;
      phi = zeros(3);
      phi_aux = zeros(3);
      phi_reinit = zeros(3);
      phi_d1 = 0;
      T_abs = identity(3);
      when initial() then
        T_fix = pre(T_fix);
      end when;

    elseif useQuaternions then
      /* Quaternions will be used as potential states
       leading to dynamic state selection during integration
    */
      w_a = Frames.Quaternions.angularVelocity2(Q, der(Q));
      z_a = der(w_a);
      frame_a.R = Frames.from_Q(Q);
      {0} = Frames.Quaternions.orientationConstraint(Q);
      s1 = 0;
      s2 = 0;
      s3 = 0;
      c1 = 0;
      c2 = 0;
      c2a = 0;
      c3 = 0;
      phi = zeros(3);
      phi_aux = zeros(3);
      phi_reinit = zeros(3);
      phi_d1 = 0;
      T_abs = identity(3);
      when initial() then
        T_fix = pre(T_fix);
      end when;

    else
      Q = Frames.Quaternions.nullRotation();

      // Cardan angles will be used as states (= minimal coordinates)
      s1 = Modelica.Math.sin(phi[1]);
      s2 = Modelica.Math.sin(phi[2]);
      s3 = Modelica.Math.sin(phi[3]);
      c1 = Modelica.Math.cos(phi[1]);
      c2a = Modelica.Math.cos(phi[2]);
      c3 = Modelica.Math.cos(phi[3]);

      /* Below, some expressions are divided by c2a. Due to the change
     of the base frame T_fix, it is not possible that c2a=0, during
     continuous simulation. However, at initial time, at internal large
     steps of the integrator, this may occur resulting in a
     division by zero. This is avoided by:
     - an "assert(..)" signals to the integrator to reduce the
       step size, once the assert conditions become false.
     - c2 = c2a if c2a is not zero, and c2 is a small value when c2a is
       around zero.
  */
      assert(c2a > c2_small or c2a < -c2_small,
        "Singularity of actual angle sequence reached. Should not occur");
      c2 = noEvent(if c2a > c2_small or c2a < -c2_small then c2a else (if c2a
         >= 0 then c2_small else -c2_small));

      /* Absolute transformation matrix from world frame to frame_a of body
       T_abs = [ c3, s3, 0;
                -s3, c3, 0;
                  0, 0, 1]*[c2, 0, -s2;
                             0, 1, 0;
                            s2, 0, c2]*[1, 0, 0;
                                        0, c1, s1;
                                        0, -s1, c1]*T_fix;
  */
      T_abs = [c2*c3, c1*s3 + s1*s2*c3, s1*s3 - c1*s2*c3; -c2*s3, c1*c3 - s1*s2
        *s3, s1*c3 + c1*s2*s3; s2, -s1*c2, c1*c2]*pre(T_fix);
      frame_a.R = Frames.from_T(T_abs);

      when phi[2] >= phi2_critical or phi[2] <= -phi2_critical then
        T_fix = T_abs;
        phi_reinit = -phi_aux;
      end when;
      phi = phi_aux + pre(phi_reinit);

      /*
     w_a ={0,0,phi_d[3]} + [ c3, s3, 0;
                            -s3, c3, 0;
                              0,  0, 1]*{0,phi_d[2],0} + [ c3, s3, 0;
                                                          -s3, c3, 0;
                                                            0,  0, 1]*[c2, 0, -s2;
                                                                        0, 1, 0;
                                                                        s2, 0, c2]*{phi_d[1],0,0}
         = A(phi)*phi_d
     -> phi_d = inv(A)*w_a
   */
      phi_d1 = (c3*w_a[1] - s3*w_a[2])/c2;
      der(phi_aux) = {phi_d1,c3*w_a[2] + s3*w_a[1],w_a[3] - s2*phi_d1};
      der(w_a) = z_a;
    end if;
    // end of rotational kinematic differential equations ------------------

    // translational kinematic differential equations
    v_0 = der(frame_a.r_0);
    a_0 = der(v_0);

    // gravity acceleration at center of mass resolved in world frame
    g_0 = world.gravityAcceleration(frame_a.r_0 + Frames.resolve1(frame_a.R,
      r_CM));

    /* Newton/Euler equations with respect to frame_a
     - The equations are written with respect to frame_a, since usually
       variables at a specific geometric point are better suited as
       state variables, than variables from the center of mass
     - The equations are written such that only one vector (a_0 - g0)
       is transformed from the world frame to frame_a and not two
       vectors (a_0 and g_0). The original equations are:
              a_CM = a_a + cross(z_a, r_CM) + cross(w_a, cross(w_a, r_CM));
              f_CM = m*a_CM - m*g_a;
              t_CM = I*z_a + cross(w_a, I*w_a);
         frame_a.f = f_CM
         frame_a.t = t_CM + cross(r_CM, f_CM);
  */
    frame_a.f = m*(Frames.resolve2(frame_a.R, a_0 - g_0) + cross(z_a, r_CM) +
      cross(w_a, cross(w_a, r_CM)));
    frame_a.t = I*z_a + cross(w_a, I*w_a) + cross(r_CM, frame_a.f);

  end Body;

  model BodyShape
    "Rigid body with mass, inertia tensor, different shapes for animation, and two frame connectors (12 potential states)"


    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    Interfaces.Frame_a frame_a annotation (extent=[-120, -15; -100, 15]);
    Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);
    parameter Boolean animation=true
      "= true, if animation shall be enabled (show shape between frame_a and frame_b and optionally a sphere at the center of mass)";
    parameter Boolean animateSphere=true
      "= true, if mass shall be animated as sphere provided animation=true";
    parameter SI.Position r[3]={0,0,0}
      "Vector from frame_a to frame_b resolved in frame_a";
    parameter SI.Position r_CM[3]={0,0,0}
      "Vector from frame_a to center of mass, resolved in frame_a";
    parameter SI.Mass m=1 "Mass of rigid body";
    parameter SI.Inertia I_11=0.001
      "|Inertia tensor (resolved in center of mass, parallel to frame_a)| (1,1) element of inertia tensor";
    parameter SI.Inertia I_22=0.001
      "|Inertia tensor (resolved in center of mass, parallel to frame_a)| (2,2) element of inertia tensor";
    parameter SI.Inertia I_33=0.001
      "|Inertia tensor (resolved in center of mass, parallel to frame_a)| (3,3) element of inertia tensor";
    parameter SI.Inertia I_21=0
      "|Inertia tensor (resolved in center of mass, parallel to frame_a)| (2,1) element of inertia tensor";
    parameter SI.Inertia I_31=0
      "|Inertia tensor (resolved in center of mass, parallel to frame_a)| (3,1) element of inertia tensor";
    parameter SI.Inertia I_32=0
      "|Inertia tensor (resolved in center of mass, parallel to frame_a)| (3,2) element of inertia tensor";
    parameter Types.Init.Temp initType=Types.Init.Free
      "|Initialization|| Type of initialization (defines usage of start values below)";
    parameter SI.Position r_0_start[3]={0,0,0}
      "|Initialization|| Initial values of frame_a.r_0 (vector from origin of world frame to origin of frame_a resolved in world frame)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.RotationSequence sequence_start={1,2,3}
      "|Initialization|| Sequence of rotations to rotate world frame into frame_a at initial time"
      annotation (Evaluate=true);
    parameter NonSI.Angle_deg angles_start[3]={0,0,0}
      "|Initialization|| Initial values of angles to rotate world frame around 'sequence_start' axes into frame_a"
      annotation (Evaluate=false);
    parameter SI.Velocity v_0_start[3]={0,0,0}
      "|Initialization|| Initial values of velocity v_0 = der(frame_a.r_0)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.AngularVelocity_degs w_0_start[3]={0,0,0}
      "|Initialization|| Initial values of angular velocity of frame_a resolved in world frame"
      annotation (Evaluate=false);
    parameter SI.Acceleration a_0_start[3]={0,0,0}
      "|Initialization|| Initial values of acceleration a_0 = der(v_0)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.AngularAcceleration_degs2 z_0_start[3]={0,0,0}
      "|Initialization|| Initial values of angular acceleration z_0 = der(w_0)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.ShapeType shapeType="cylinder"
      "|Animation|if animation = true| Type of shape";
    parameter SI.Position r_shape[3]={0,0,0}
      "|Animation|if animation = true| Vector from frame_a to shape origin, resolved in frame_a";
    parameter MultiBody.Types.Axis lengthDirection=r - r_shape
      "|Animation|if animation = true| Vector in length direction of shape, resolved in frame_a"
      annotation (Evaluate=true);
    parameter MultiBody.Types.Axis widthDirection={0,1,0}
      "|Animation|if animation = true| Vector in width direction of shape, resolved in frame_a"
      annotation (Evaluate=true);
    parameter SI.Length length=Frames.length(r - r_shape)
      "|Animation|if animation = true| Length of shape";
    parameter SI.Distance width=length/world.defaultWidthFraction
      "|Animation|if animation = true| Width of shape";
    parameter SI.Distance height=width
      "|Animation|if animation = true| Height of shape.";
    parameter Real extra=0.0
      "|Animation|if animation = true| Additional parameter depending on shapeType (see docu of Visualizers.Advanced.Shape).";
    parameter MultiBody.Types.Color color=MultiBody.Types.Defaults.BodyColor
      "|Animation|if animation = true| Color of shape";
    parameter SI.Diameter sphereDiameter=2*width
      "|Animation|if animation = true and animateSphere = true| Diameter of sphere";
    parameter MultiBody.Types.Color sphereColor=color
      "|Animation|if animation = true and animateSphere = true| Color of sphere of mass";
    parameter Boolean useQuaternions=true
      "|Advanced|| = true, if quaternions shall be utilized when body states are required, otherwise switch between sets of 3 Cardan angles";
    parameter Boolean enforceStates=false
      "|Advanced|| = true, if absolute variables of body object shall be used as states";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.24,
        y=0.1,
        width=0.6,
        height=0.73),
      Documentation(info="<HTML>
<p>
<b>Rigid body</b> with mass and inertia tensor and <b>two frame connectors</b>.
All parameter vectors have to be resolved in frame_a.
The <b>inertia tensor</b> has to be defined with respect to a
coordinate system that is parallel to frame_a with the
origin at the center of mass of the body. The coordinate system <b>frame_b</b>
is always parallel to <b>frame_a</b>.
</p>
<p>
By default, this component is visualized by any <b>shape</b> that can be
defined with MultiBody.Visualizers.FixedShape. This shape is placed
between frame_a and frame_b (default: length(shape) = Frames.length(r)).
Additionally a <b>sphere</b> may be visualized that has
its center at the center of mass.
Note, that
the animation may be switched off via parameter animation = <b>false</b>.
</p>
<IMG SRC=\"../Images/BodyShape.png\" ALT=\"Parts.BodyShape\">
<p>
The following shapes can be defined via parameter <b>shapeType</b>,
e.g., shapeType=\"cone\":
</p>
<IMG SRC=\"../Images/FixedShape.png\" ALT=\"Visualizers.FixedShape\">
<p>
A BodyShape component has potential states. For details of these
states and of the \"Advanced\" menu parameters, see model
<b>MultiBody.Parts.Body</b>.
</p>
</HTML>
"),
      Icon(
        Text(extent=[-134, 126; 126, 66], string="%name"),
        Text(
          extent=[122, -123; -138, -73],
          string="%=r",
          style(color=0)),
        Rectangle(extent=[-100, 31; 101, -30], style(
            color=8,
            gradient=2,
            fillColor=69)),
        Ellipse(extent=[-60, 60; 60, -60], style(gradient=3, fillColor=69)),
        Text(
          extent=[-50, 24; 55, -27],
          string="%m",
          style(color=0)),
        Text(
          extent=[63, 11; 99, -14],
          string="b",
          style(color=0)),
        Text(
          extent=[-99, 13; -63, -12],
          string="a",
          style(color=0))),
      Diagram(
        Line(points=[-100, 9; -100, 43], style(color=10)),
        Line(points=[100, 0; 100, 44], style(color=10)),
        Line(points=[-100, 40; 90, 40], style(color=10)),
        Polygon(points=[90, 44; 90, 36; 100, 40; 90, 44], style(
            color=10,
            fillColor=10,
            fillPattern=1)),
        Text(
          extent=[-22, 68; 20, 40],
          string="r",
          style(color=10)),
        Line(points=[-100, -10; -100, -90], style(color=10)),
        Line(points=[-100, -84; -10, -84], style(color=10)),
        Polygon(points=[-10, -80; -10, -88; 0, -84; -10, -80], style(color=10,
              fillColor=10)),
        Text(
          extent=[-82, -66; -56, -84],
          string="r_CM",
          style(color=10)),
        Line(points=[0, -46; 0, -90], style(color=10))));

    FixedTranslation frameTranslation(r=r, animation=false)
      annotation (extent=[-40, -20; 40, 20]);
    Body body(
      r_CM=r_CM,
      m=m,
      I_11=I_11,
      I_22=I_22,
      I_33=I_33,
      I_21=I_21,
      I_31=I_31,
      I_32=I_32,
      animation=false,
      initType=initType,
      r_0_start=r_0_start,
      sequence_start=sequence_start,
      angles_start=angles_start,
      v_0_start=v_0_start,
      w_0_start=w_0_start,
      a_0_start=a_0_start,
      z_0_start=z_0_start,
      useQuaternions=useQuaternions,
      enforceStates=enforceStates)
      annotation (extent=[-27.3333, -70.3333; 13, -30]);
  protected
    outer MultiBody.World world;
    parameter Integer ndim1=if world.enableAnimation and animation then 1 else
        0;
    parameter Integer ndim2=if world.enableAnimation and animation and
        animateSphere then 1 else 0;
    Visualizers.Advanced.Shape shape1[ndim1](
      each shapeType=shapeType,
      each color=color,
      each length=length,
      each width=width,
      each height=height,
      each lengthDirection=lengthDirection,
      each widthDirection=widthDirection,
      each r_shape=r_shape,
      each extra=extra,
      each r=frame_a.r_0,
      each R=frame_a.R);
    Visualizers.Advanced.Shape shape2[ndim2](
      each shapeType="sphere",
      each color=sphereColor,
      each length=sphereDiameter,
      each width=sphereDiameter,
      each height=sphereDiameter,
      each lengthDirection={1,0,0},
      each widthDirection={0,1,0},
      each r_shape=r_CM - {1,0,0}*sphereDiameter/2,
      each r=frame_a.r_0,
      each R=frame_a.R);
  equation
    connect(frame_a, frameTranslation.frame_a)
      annotation (points=[-110, 0; -44, 0], style(color=0, thickness=2));
    connect(frame_b, frameTranslation.frame_b)
      annotation (points=[110, 0; 44, 0], style(color=0, thickness=2));
    connect(frame_a, body.frame_a) annotation (points=[-110, 0; -60, 0; -60, -50.1666;
           -29.35, -50.1666], style(
        color=0,
        thickness=2,
        fillColor=0,
        fillPattern=1));
  end BodyShape;

  model BodyBox
    "Rigid body with box shape. Mass and animation properties are computed from box data and density (12 potential states)"


    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    Interfaces.Frame_a frame_a annotation (extent=[-120, -15; -100, 15]);
    Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);
    parameter Boolean animation=true
      "= true, if animation shall be enabled (show box between frame_a and frame_b)";
    parameter SI.Position r[3]={0.1,0,0}
      "Vector from frame_a to frame_b resolved in frame_a";
    parameter SI.Position r_shape[3]={0,0,0}
      "Vector from frame_a to box origin, resolved in frame_a";
    parameter MultiBody.Types.Axis lengthDirection=r - r_shape
      "Vector in length direction of box, resolved in frame_a"
      annotation (Evaluate=true);
    parameter MultiBody.Types.Axis widthDirection={0,1,0}
      "Vector in width direction of box, resolved in frame_a"
      annotation (Evaluate=true);
    parameter SI.Length length=Frames.length(r - r_shape) "Length of box";
    parameter SI.Distance width=length/world.defaultWidthFraction
      "Width of box";
    parameter SI.Distance height=width "Height of box";
    parameter SI.Distance innerWidth=0
      "Width of inner box surface (0 <= innerWidth <= width)";
    parameter SI.Distance innerHeight=innerWidth
      "Height of inner box surface (0 <= innerHeight <= height)";
    parameter Real density(
      quantity="Density",
      unit="g/cm3",
      min=0) = 7.7
      "Density of box (e.g., steel: 7.7 .. 7.9, wood : 0.4 .. 0.8)";
    parameter MultiBody.Types.Color color=MultiBody.Types.Defaults.BodyColor
      "Color of box";

    parameter Types.Init.Temp initType=Types.Init.Free
      "|Initialization|| Type of initialization (defines usage of start values below)";
    parameter SI.Position r_0_start[3]={0,0,0}
      "|Initialization|| Initial values of frame_a.r_0 (vector from origin of world frame to origin of frame_a resolved in world frame)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.RotationSequence sequence_start={1,2,3}
      "|Initialization|| Sequence of rotations to rotate world frame into frame_a at initial time"
      annotation (Evaluate=true);
    parameter NonSI.Angle_deg angles_start[3]={0,0,0}
      "|Initialization|| Initial values of angles to rotate world frame around 'sequence_start' axes into frame_a"
      annotation (Evaluate=false);
    parameter SI.Velocity v_0_start[3]={0,0,0}
      "|Initialization|| Initial values of velocity v_0 = der(frame_a.r_0)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.AngularVelocity_degs w_0_start[3]={0,0,0}
      "|Initialization|| Initial values of angular velocity of frame_a resolved in world frame"
      annotation (Evaluate=false);
    parameter SI.Acceleration a_0_start[3]={0,0,0}
      "|Initialization|| Initial values of acceleration a_0 = der(v_0)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.AngularAcceleration_degs2 z_0_start[3]={0,0,0}
      "|Initialization|| Initial values of angular acceleration z_0 = der(w_0)"
      annotation (Evaluate=false);

    parameter Boolean useQuaternions=true
      "|Advanced|| = true, if quaternions shall be utilized when body states are required, otherwise switch between sets of 3 Cardan angles";
    parameter Boolean enforceStates=false
      "|Advanced|| = true, if absolute variables of body object shall be used as states";

    final parameter SI.Mass mo=1000*density*length*width*height
      "Mass of box without hole";
    final parameter SI.Mass mi=1000*density*length*innerWidth*innerHeight
      "Mass of hole of box";
    final parameter SI.Mass m=mo - mi "Mass of box";
    final parameter Frames.Orientation R=Frames.from_nxy(r, widthDirection);
    final parameter SI.Position r_CM[3]=Frames.normalize(r)*length/2;
    final parameter SI.Inertia I[3, 3]=Frames.resolveDyade1(R, diagonal({mo*(
        width*width + height*height) - mi*(innerWidth*innerWidth + innerHeight*
        innerHeight),mo*(length*length + height*height) - mi*(length*length +
        innerHeight*innerHeight),mo*(length*length + width*width) - mi*(length*
        length + innerWidth*innerWidth)}/12));
    Body body(
      animation=false,
      r_CM=r_CM,
      m=m,
      I_11=I[1, 1],
      I_22=I[2, 2],
      I_33=I[3, 3],
      I_21=I[2, 1],
      I_31=I[3, 1],
      I_32=I[3, 2],
      initType=initType,
      r_0_start=r_0_start,
      sequence_start=sequence_start,
      angles_start=angles_start,
      v_0_start=v_0_start,
      w_0_start=w_0_start,
      a_0_start=a_0_start,
      z_0_start=z_0_start,
      useQuaternions=useQuaternions,
      enforceStates=enforceStates) annotation (extent=[-30, -80; 10, -40]);
    FixedTranslation frameTranslation(
      r=r,
      animation=animation,
      shapeType="box",
      r_shape=r_shape,
      lengthDirection=lengthDirection,
      widthDirection=widthDirection,
      length=length,
      width=width,
      height=height,
      color=color) annotation (extent=[-30, -30; 30, 30]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.22,
        y=0.09,
        width=0.72,
        height=0.68),
      Documentation(info="<HTML>
<p>
<b>Rigid body</b> with <b>box</b> shape.
The mass properties of the body (mass, center of mass,
inertia tensor) are computed
from the box data. Optionally, the box may be hollow.
The (outer) box shape is by default used in the animation.
The hollow part is not shown in the animation.
The two connector frames <b>frame_a</b> and <b>frame_b</b>
are always parallel to each other. Example of component
animation (note, that
the animation may be switched off via parameter animation = <b>false</b>):
</p>
<IMG SRC=\"../Images/BodyBox.png\" ALT=\"Parts.BodyBox\">
<p>
A BodyBox component has potential states. For details of these
states and of the \"Advanced\" menu parameters, see model
<b>MultiBody.Parts.Body</b>.
</p>
</HTML>
"),
      Icon(
        Polygon(points=[100, 40; 100, -30; 90, -40; 90, 30; 100, 40], style(
            color=70,
            fillColor=70,
            fillPattern=1)),
        Rectangle(extent=[-100, 30; 90, -40], style(
            color=69,
            pattern=0,
            fillColor=69)),
        Polygon(points=[-100, 30; -90, 40; 100, 40; 90, 30; -100, 30], style(
              color=70, fillColor=70)),
        Text(extent=[-129, 100; 131, 40], string="%name"),
        Text(
          extent=[130, -98; -130, -48],
          string="%=r",
          style(color=0)),
        Text(
          extent=[60, 7; 96, -18],
          string="b",
          style(color=0)),
        Text(
          extent=[-98, 12; -62, -13],
          string="a",
          style(color=0))),
      Diagram);

  protected
    outer MultiBody.World world;
  equation

    assert(innerWidth <= width,
      "parameter innerWidth is greater as parameter width");
    assert(innerHeight <= height,
      "parameter innerHeight is greater as paraemter height");
    connect(body.frame_a, frame_a)
      annotation (points=[-32, -60; -80, -60; -80, 0; -110, 0]);
    connect(frameTranslation.frame_b, frame_b)
      annotation (points=[33, 0; 110, 0]);
    connect(frameTranslation.frame_a, frame_a)
      annotation (points=[-33, 0; -110, 0]);
  end BodyBox;

  model BodyCylinder
    "Rigid body with cylinder shape. Mass and animation properties are computed from cylinder data and density (12 potential states)"


    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    Interfaces.Frame_a frame_a annotation (extent=[-120, -15; -100, 15]);
    Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);
    parameter Boolean animation=true
      "= true, if animation shall be enabled (show cylinder between frame_a and frame_b)";
    parameter SI.Position r[3]={0.1,0,0}
      "Vector from frame_a to frame_b, resolved in frame_a";
    parameter SI.Position r_shape[3]={0,0,0}
      "Vector from frame_a to cylinder origin, resolved in frame_a";
    parameter MultiBody.Types.Axis lengthDirection=r - r_shape
      "Vector in length direction of cylinder, resolved in frame_a"
      annotation (Evaluate=true);
    parameter SI.Length length=Frames.length(r - r_shape) "Length of cylinder";
    parameter SI.Distance diameter=length/world.defaultWidthFraction
      "Diameter of cylinder";
    parameter SI.Distance innerDiameter=0
      "Inner diameter of cylinder (0 <= innerDiameter <= Diameter)";
    parameter Real density(
      quantity="Density",
      unit="g/cm3") = 7.7
      "Density of cylinder (e.g., steel: 7.7 .. 7.9, wood : 0.4 .. 0.8)";
    parameter MultiBody.Types.Color color=MultiBody.Types.Defaults.BodyColor
      "Color of cylinder";

    parameter Types.Init.Temp initType=Types.Init.Free
      "|Initialization|| Type of initialization (defines usage of start values below)";
    parameter SI.Position r_0_start[3]={0,0,0}
      "|Initialization|| Initial values of frame_a.r_0 (vector from origin of world frame to origin of frame_a resolved in world frame)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.RotationSequence sequence_start={1,2,3}
      "|Initialization|| Sequence of rotations to rotate world frame into frame_a at initial time"
      annotation (Evaluate=true);
    parameter NonSI.Angle_deg angles_start[3]={0,0,0}
      "|Initialization|| Initial values of angles to rotate world frame around 'sequence_start' axes into frame_a"
      annotation (Evaluate=false);
    parameter SI.Velocity v_0_start[3]={0,0,0}
      "|Initialization|| Initial values of velocity v_0 = der(frame_a.r_0)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.AngularVelocity_degs w_0_start[3]={0,0,0}
      "|Initialization|| Initial values of angular velocity of frame_a resolved in world frame"
      annotation (Evaluate=false);
    parameter SI.Acceleration a_0_start[3]={0,0,0}
      "|Initialization|| Initial values of acceleration a_0 = der(v_0)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.AngularAcceleration_degs2 z_0_start[3]={0,0,0}
      "|Initialization|| Initial values of angular acceleration z_0 = der(w_0)"
      annotation (Evaluate=false);

    parameter Boolean useQuaternions=true
      "|Advanced|| = true, if quaternions shall be utilized when body states are required, otherwise switch between sets of 3 Cardan angles";
    parameter Boolean enforceStates=false
      "|Advanced|| = true, if absolute variables of body object shall be used as states";

    constant Real pi=Modelica.Constants.pi;
    final parameter SI.Distance radius=diameter/2;
    final parameter SI.Distance innerRadius=innerDiameter/2;
    final parameter SI.Mass mo=1000*density*pi*length*radius*radius
      "Mass of cylinder without hole";
    final parameter SI.Mass mi=1000*density*pi*length*innerRadius*innerRadius
      "Mass of hole of cylinder";
    final parameter SI.Inertia I22=(mo*(length*length + 3*radius*radius) - mi*(
        length*length + 3*innerRadius*innerRadius))/12;
    final parameter SI.Mass m=mo - mi "Mass of cylinder";
    final parameter Frames.Orientation R=Frames.from_nxy(r, {0,1,0});
    final parameter SI.Position r_CM[3]=Frames.normalize(r)*length/2;
    final parameter SI.Inertia I[3, 3]=Frames.resolveDyade1(R, diagonal({(mo*
        radius*radius - mi*innerRadius*innerRadius)/2,I22,I22}));

    Body body(
      r_CM=r_CM,
      m=m,
      I_11=I[1, 1],
      I_22=I[2, 2],
      I_33=I[3, 3],
      I_21=I[2, 1],
      I_31=I[3, 1],
      I_32=I[3, 2],
      animation=false,
      initType=initType,
      r_0_start=r_0_start,
      sequence_start=sequence_start,
      angles_start=angles_start,
      v_0_start=v_0_start,
      w_0_start=w_0_start,
      a_0_start=a_0_start,
      z_0_start=z_0_start,
      useQuaternions=useQuaternions,
      enforceStates=enforceStates) annotation (extent=[-30, -80; 10, -40]);
    FixedTranslation frameTranslation(
      r=r,
      animation=animation,
      shapeType="pipecylinder",
      r_shape=r_shape,
      lengthDirection=lengthDirection,
      length=length,
      width=diameter,
      height=diameter,
      extra=innerDiameter/diameter,
      color=color,
      widthDirection={0,1,0}) annotation (extent=[-30, -30; 30, 30]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.22,
        y=0.09,
        width=0.72,
        height=0.68),
      Documentation(info="<HTML>
<p>
<b>Rigid body</b> with <b>cylinder</b> shape.
The mass properties of the body (mass, center of mass,
inertia tensor) are computed
from the cylinder data. Optionally, the cylinder may be hollow.
The cylinder shape is by default used in the animation.
The two connector frames <b>frame_a</b> and <b>frame_b</b>
are always parallel to each other. Example of component
animation (note, that
the animation may be switched off via parameter animation = <b>false</b>):
</p>
<IMG SRC=\"../Images/BodyCylinder.png\" ALT=\"Parts.BodyCylinder\">
<p>
A BodyCylinder component has potential states. For details of these
states and of the \"Advanced\" menu parameters, see model
<b>MultiBody.Parts.Body</b>.
</HTML>
"),
      Icon(
        Text(extent=[-129, 100; 131, 40], string="%name"),
        Text(
          extent=[130, -98; -130, -48],
          string="%=r",
          style(color=0)),
        Rectangle(extent=[-100, 40; 100, -40], style(
            color=69,
            gradient=2,
            fillColor=69)),
        Text(
          extent=[-100, 14; -64, -11],
          string="a",
          style(color=0)),
        Text(
          extent=[62, 12; 98, -13],
          string="b",
          style(color=0))),
      Diagram);

  protected
    outer MultiBody.World world;
  equation

    assert(innerDiameter < diameter,
      "parameter innerDiameter is greater as parameter diameter.");
    connect(body.frame_a, frame_a)
      annotation (points=[-32, -60; -80, -60; -80, 0; -110, 0]);
    connect(frameTranslation.frame_b, frame_b)
      annotation (points=[33, 0; 110, 0]);
    connect(frameTranslation.frame_a, frame_a)
      annotation (points=[-33, 0; -110, 0]);
  end BodyCylinder;

end Parts;
