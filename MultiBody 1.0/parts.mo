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
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Model</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Parts.Fixed\">Fixed</a></b></td>
      <td>Frame fixed in world frame at a given position.
          It is visualized with a shape, see <b>shapeType</b> below
         (the frames on the two
          sides do not belong to the component):<br>&nbsp;<br>
      <IMG SRC=\"../Images/Fixed.png\" ALT=\"model Parts.Fixed\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Parts.FixedTranslation\">FixedTranslation</a></b></td>
      <td>Fixed translation of frame_b with respect to frame_a.
          It is visualized with a shape, see <b>shapeType</b> below
          (the frames on the two sides do not belong to the component):<br>&nbsp;<br>
      <IMG SRC=\"../Images/FixedTranslation.png\" ALT=\"model Parts.FixedTranslation\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Parts.FixedRotation\">FixedRotation</a></b></td>
      <td>Fixed translation and fixed rotation of frame_b with respect to frame_a
          It is visualized with a shape, see <b>shapeType</b>  below
          (the frames on the two sides do not belong to the component):<br>&nbsp;<br>
      <IMG SRC=\"../Images/FixedRotation.png\" ALT=\"model Parts.FixedRotation\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Parts.Body\">Body</a></b></td>
      <td>Rigid body with mass, inertia tensor and one frame connector.
          It is visualized with a cylinder and a sphere at the
          center of mass:<br>&nbsp;<br>
      <IMG SRC=\"../Images/Body.png\" ALT=\"model Parts.Body\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Parts.BodyShape\">BodyShape</a></b></td>
      <td>Rigid body with mass, inertia tensor, different shapes
          (see <b>shapeType</b> below)
          for animation, and two frame connectors:<br>&nbsp;<br>
      <IMG SRC=\"../Images/BodyShape.png\" ALT=\"model Parts.BodyShape\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Parts.Fixed\">Fixed</a>
BodyBox</b></td>
      <td>Rigid body with box shape (mass and animation properties are computed
          from box data and from density):<br>&nbsp;<br>
      <IMG SRC=\"../Images/BodyBox.png\" ALT=\"model Parts.BodyBox\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Parts.BodyCylinder\">BodyCylinder</a></b></td>
      <td>Rigid body with cylinder shape (mass and animation properties
          are computed from cylinder data and from density):<br>&nbsp;<br>
      <IMG SRC=\"../Images/BodyCylinder.png\" ALT=\"model Parts.BodyCylinder\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Parts.Mounting1D\">Mounting1D</a></b></td>
      <td> Propagate 1D support torque to 3D system
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Parts.Rotor1D\">Rotor1D</a></b></td>
      <td>1D inertia attachable on 3D bodies (without neglecting dynamic effects)<br>
      <IMG SRC=\"../Images/Parts/Rotor1D.png\" ALT=\"model Parts.Rotor1D\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Parts.BevelGear1D\">BevelGear1D</a></b></td>
      <td>1D gearbox with arbitrary shaft directions (3D bearing frame)
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
All the details of the visualization shape parameters are
given in
<a href=\"Modelica://MultiBody.Visualizers.FixedShape\">Visualizers.FixedShape</a>
</p>

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
    "Fixed translation followed by a fixed rotation of frame_b with respect to frame_a"


    import MultiBody.Frames;
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
    final parameter Frames.Orientation R_rel=if rotationType == 1 then
        Frames.planarRotation(Frames.normalize(n), Cv.from_deg(angle), 0) else
        if rotationType == 2 then Frames.from_nxy(n_x, n_y) else
        Frames.axesRotations(sequence, Cv.from_deg(angles), zeros(3))
      "Fixed rotation object from frame_a to frame_b";
  protected
    outer MultiBody.World world;

    /*
  parameter Frames.Orientation R_rel_inv=
      Frames.inverseRotation(R_rel)
*/
    parameter Frames.Orientation R_rel_inv=Frames.from_T(transpose(R_rel.T),
        zeros(3)) "Inverse of R_rel (rotate from frame_b to frame_a)";

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
    frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, r);
    if rooted(frame_a.R) then
      frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
      zeros(3) = frame_a.f + Frames.resolve1(R_rel, frame_b.f);
      zeros(3) = frame_a.t + Frames.resolve1(R_rel, frame_b.t) - cross(r,
        frame_a.f);
    else
      frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel_inv);
      zeros(3) = frame_b.f + Frames.resolve1(R_rel_inv, frame_a.f);
      zeros(3) = frame_b.t + Frames.resolve1(R_rel_inv, frame_a.t) + cross(r,
        frame_b.f);
    end if;
  end FixedRotation;

  model Body
    "Rigid body with mass, inertia tensor and one frame connector (12 potential states)"


    import SI = Modelica.SIunits;
    import Cv = Modelica.SIunits.Conversions;
    import Modelica.Math.*;
    Interfaces.Frame_a frame_a(r_0(start=r_0_start, stateSelect=if
            enforceStates then StateSelect.always else StateSelect.default))
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
      " Initial values of velocity v_0 = der(frame_a.r_0)"
      annotation (Evaluate=false, Dialog(tab="Initialization"));
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
      "Diameter of sphere" annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    parameter Types.Color sphereColor=MultiBody.Types.Defaults.BodyColor
      "Color of sphere" annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    parameter SI.Diameter cylinderDiameter=sphereDiameter/MultiBody.Types.
        Defaults.BodyCylinderDiameterFraction "Diameter of cylinder"
      annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    parameter Types.Color cylinderColor=sphereColor "Color of cylinder"
      annotation (Dialog(
        tab="Animation",
        group="if animation = true",
        enable=animation));
    parameter Boolean enforceStates=false
      " = true, if absolute variables of body object shall be used as states"
      annotation (Dialog(tab="Advanced"));
    parameter Boolean useQuaternions=true
      " = true, if quaternions shall be used as potential states otherwise use 3 angles as potential states"
      annotation (Dialog(tab="Advanced"));
    parameter Types.RotationSequence sequence_angleStates={1,2,3}
      " Sequence of rotations to rotate world frame into frame_a around the 3 angles used as potential states"
       annotation (Evaluate=true, Dialog(tab="Advanced", enable=not
            useQuaternions));
    final parameter SI.Inertia I[3, 3]=[I_11, I_21, I_31; I_21, I_22, I_32;
        I_31, I_32, I_33] "inertia tensor";
    final parameter Frames.Orientation R_start=MultiBody.Frames.axesRotations(
        sequence_start, Cv.from_deg(angles_start), zeros(3))
      "Orientation object from world frame to frame_a at initial time";
    final parameter SI.AngularVelocity w_a_start[3]=MultiBody.Frames.resolve2(
        R_start, w_0_start*Modelica.Constants.D2R);
    final parameter SI.AngularAcceleration z_a_start[3]=
        MultiBody.Frames.resolve2(R_start, z_0_start*Modelica.Constants.D2R);

    SI.Velocity v_0[3](start=v_0_start, stateSelect=if enforceStates then
          StateSelect.always else StateSelect.default)
      "Absolute velocity of frame_a, resolved in world frame";
    SI.Acceleration a_0[3]
      "Absolute acceleration of frame_a resolved in world frame";
    SI.AngularVelocity w_a[3](start=w_a_start, stateSelect=if enforceStates
           then (if useQuaternions then StateSelect.always else StateSelect.
          avoid) else StateSelect.default)
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
<b>States of Body Components</b>
</p>
<p>
Every body has potential states. If possible a tool will select
the states of joints and not the states of bodies because this is
usually the most efficient choice. In this case the position, orientation,
velocity and angular velocity of frame_a of the body will be computed
by the component that is connected to frame_a. However, if a body is moving
freely in space, variables of the body have to be used as states. The potential
states of the body are:
</p>
<ul>
<li> The <b>position vector</b> frame_a.r_0 from the origin of the
     world frame to the origin of frame_a of the body, resolved in
     the world frame and the <b>absolute velocity</b> v_0 of the origin of
     frame_a, resolved in the world frame (= der(frame_a.r_0)).</li>
</li>
<li> If parameter <b>useQuaternions</b> in the \"Advanced\" menu
     is <b>true</b> (this is the default), then <b>4 quaternions</b>
     are potential states. Additionally, the coordinates of the
     absolute angular velocity vector of the
     body are 3 potential states.<br>
     If <b>useQuaternions</b> in the \"Advanced\" menu
     is <b>false</b>, then <b>3 angles</b> and the derivatives of
     these angles are potential states. The orientation of frame_a
     is computed by rotating the world frame along the axes defined
     in parameter vector \"sequence_angleStates\" (default = {1,2,3}, i.e.,
     the Cardan angle sequence) around the angles used as potential states.
     For example, the default is to rotate the x-axis of the world frame
     around angles[1], the new y-axis around angles[2] and the new z-axis
     around angles[3], arriving at frame_a.
 </li>
</ul>
<p>
The quaternions have the slight disadvantage that there is a
non-linear constraint equation between the 4 quaternions.
Therefore, at least one non-linear equation has to be solved
during simulation. A tool might, however, analytically solve this
simple constraint equation. Using the 3 angles as states has the
disadvantage that there is a singular configuration in which a
division by zero will occur. If it is possible to determine in advance
for an application class that this singular configuration is outside
of the operating region, the 3 angles might be used as potential
states by setting <b>useQuaternions</b> = <b>false</b>.
</p>
<p>
In text books about 3-dimensional mechanics often 3 angles and the
angular velocity are used as states. This is not the case here, since
3 angles and their derivatives are used as potential states
(if useQuaternions = false). The reason
is that for real-time simulation the discretization formula of the
integrator might be \"inlined\" and solved together with the body equations.
By appropriate symbolic transformation the performance is
drastically increased if angles and their
derivatives are used as states, instead of angles and the angular
velocity.
</p>
<p>
Whether or not variables of the body are used as states is usually
automatically selected by the Modelica translator. If parameter
<b>enforceStates</b> is set to <b>true</b> in the \"Advanced\" menu,
then body variables are forced to be used as states according
to the setting of parameters \"useQuaternions\" and
\"sequence_angleStates\".
</p>
</HTML>"));

  protected
    outer MultiBody.World world;

    // Declarations for quaternions (dummies, if quaternions are not used)
    parameter Frames.Quaternions.Orientation Q_start=MultiBody.Frames.to_Q(
        R_start)
      "Quaternion orientation object from world frame to frame_a at initial time";
    Frames.Quaternions.Orientation Q(start=Q_start, stateSelect=if
          enforceStates then (if useQuaternions then StateSelect.prefer else
          StateSelect.never) else StateSelect.default)
      "Quaternion orientation object from world frame to frame_a (dummy value, if quaternions are not used as states)";

    // Declaration for 3 angles
    parameter SI.Angle phi_start[3]=if sequence_start[1] ==
        sequence_angleStates[1] and sequence_start[2] == sequence_angleStates[2]
         and sequence_start[3] == sequence_angleStates[3] then Cv.from_deg(
        angles_start) else Frames.axesRotationsAngles(R_start,
        sequence_angleStates) "Potential angle states at initial time";
    SI.Angle phi[3](start=phi_start, stateSelect=if enforceStates then (if
          useQuaternions then StateSelect.never else StateSelect.always) else
          StateSelect.default)
      "Dummy or 3 angles to rotate world frame into frame_a of body";
    SI.AngularVelocity phi_d[3](stateSelect=if enforceStates then (if
          useQuaternions then StateSelect.never else StateSelect.always) else
          StateSelect.default) "= der(phi)";
    SI.AngularAcceleration phi_dd[3] "= der(phi_d)";

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
  initial equation
    if initType == Types.Init.Position or initType == Types.Init.
        PositionVelocity or initType == Types.Init.PositionVelocityAcceleration
         then
      // Initialize positional variables
      frame_a.r_0 = r_0_start;
      if not isRoot(frame_a.R) then
        // frame_a.R is computed somewhere else
        zeros(3) = Frames.Orientation.equalityConstraint(frame_a.R, R_start);
      elseif useQuaternions then
        // frame_a.R is computed from quaternions Q
        zeros(3) = Frames.Quaternions.Orientation.equalityConstraint(Q, Q_start);
      else
        // frame_a.R is computed from the 3 angles 'phi'
        phi = phi_start;
      end if;
    end if;

    if initType == Types.Init.PositionVelocity or initType == Types.Init.
        PositionVelocityAcceleration or initType == Types.Init.Velocity or
        initType == Types.Init.VelocityAcceleration then
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

  equation
    if enforceStates then
      defineRoot(frame_a.R);
    else
      definePotentialRoot(frame_a.R);
    end if;

    if not isRoot(frame_a.R) then
      // Body does not have states
      // Dummies
      Q = {0,0,0,1};
      phi = zeros(3);
      phi_d = zeros(3);
      phi_dd = zeros(3);
    elseif useQuaternions then
      // Use Quaternions as states (with dynamic state selection)
      frame_a.R = Frames.from_Q(Q, Frames.Quaternions.angularVelocity2(Q, der(Q)));
      {0} = Frames.Quaternions.orientationConstraint(Q);

      // Dummies
      phi = zeros(3);
      phi_d = zeros(3);
      phi_dd = zeros(3);
    else
      // Use Cardan angles as states
      phi_d = der(phi);
      phi_dd = der(phi_d);
      frame_a.R = Frames.axesRotations(sequence_angleStates, phi, phi_d);

      // Dummies
      Q = {0,0,0,1};
    end if;

    // gravity acceleration at center of mass resolved in world frame
    g_0 = world.gravityAcceleration(frame_a.r_0 + Frames.resolve1(frame_a.R,
      r_CM));

    // translational kinematic differential equations
    v_0 = der(frame_a.r_0);
    a_0 = der(v_0);

    // rotational kinematic differential equations
    w_a = Frames.angularVelocity2(frame_a.R);
    z_a = der(w_a);

    /* Newton/Euler equations with respect to center of mass
            a_CM = a_a + cross(z_a, r_CM) + cross(w_a, cross(w_a, r_CM));
            f_CM = m*(a_CM - g_a);
            t_CM = I*z_a + cross(w_a, I*w_a);
       frame_a.f = f_CM
       frame_a.t = t_CM + cross(r_CM, f_CM);
    Inserting the first three equations in the last two results in:
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
    parameter Boolean enforceStates=false
      " = true, if absolute variables of body object shall be used as states"
      annotation (Dialog(tab="Advanced"));
    parameter Boolean useQuaternions=true
      " = true, if quaternions shall be used as potential states otherwise use 3 angles as potential states"
      annotation (Dialog(tab="Advanced"));
    parameter Types.RotationSequence sequence_angleStates={1,2,3}
      " Sequence of rotations to rotate world frame into frame_a around the 3 angles used as potential states"
       annotation (Evaluate=true, Dialog(tab="Advanced", enable=not
            useQuaternions));
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
<a href=\"Modelica:MultiBody.Parts.Body\">MultiBody.Parts.Body</a>.
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
      enforceStates=enforceStates,
      sequence_angleStates=sequence_angleStates)
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
    parameter Boolean enforceStates=false
      " = true, if absolute variables of body object shall be used as states"
      annotation (Dialog(tab="Advanced"));
    parameter Boolean useQuaternions=true
      " = true, if quaternions shall be used as potential states otherwise use 3 angles as potential states"
      annotation (Dialog(tab="Advanced"));
    parameter Types.RotationSequence sequence_angleStates={1,2,3}
      " Sequence of rotations to rotate world frame into frame_a around the 3 angles used as potential states"
       annotation (Evaluate=true, Dialog(tab="Advanced", enable=not
            useQuaternions));

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
      enforceStates=enforceStates,
      sequence_angleStates=sequence_angleStates)
      annotation (extent=[-30, -80; 10, -40]);
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
<a href=\"Modelica:MultiBody.Parts.Body\">MultiBody.Parts.Body</a>.</p>
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

    parameter Boolean enforceStates=false
      " = true, if absolute variables of body object shall be used as states"
      annotation (Dialog(tab="Advanced"));
    parameter Boolean useQuaternions=true
      " = true, if quaternions shall be used as potential states otherwise use 3 angles as potential states"
      annotation (Dialog(tab="Advanced"));
    parameter Types.RotationSequence sequence_angleStates={1,2,3}
      " Sequence of rotations to rotate world frame into frame_a around the 3 angles used as potential states"
       annotation (Evaluate=true, Dialog(tab="Advanced", enable=not
            useQuaternions));

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
      enforceStates=enforceStates,
      sequence_angleStates=sequence_angleStates)
      annotation (extent=[-30, -80; 10, -40]);
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
<a href=\"Modelica:MultiBody.Parts.Body\">MultiBody.Parts.Body</a>.</HTML>
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

  model Mounting1D "Propagate 1D support torque to 3D system"
    parameter Modelica.SIunits.Angle phi0=0 "Fixed offset angle of housing";
    parameter MultiBody.Types.Axis n={1,0,0}
      "Axis of rotation = axis of support torque (resolved in frame_a)";

    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
      "(right) flange fixed in housing" annotation (extent=[110, 10; 90, -10]);
    MultiBody.Interfaces.Frame_a frame_a "Frame in which housing is fixed"
      annotation (extent=[-15, -120; 15, -100], rotation=90);
    annotation (
      Icon(
        Rectangle(extent=[-80, -60; 80, -100], style(color=0, fillColor=7)),
        Text(extent=[0, 100; 0, 40], string="%name=%phi0"),
        Line(points=[80, -60; 40, -100], style(color=0)),
        Line(points=[40, -60; 0, -100], style(color=0)),
        Line(points=[0, -60; -40, -100], style(color=0)),
        Line(points=[-40, -60; -80, -100], style(color=0)),
        Line(points=[0, -60; 0, 0], style(color=0)),
        Line(points=[0, 0; 90, 0], style(color=0))),
      Documentation(info="<html>

<p>This component is used to acquire support torques from a 1D-rotational
mechanical system (e.g., components from Modelica.Mechanics.Rotational)
and to propagate them to a carrier body.</p>

<p>The 1D support torque at <tt>flange_b</tt> is transformed into 3D space under
consideration of the rotation axis, parameter <tt>n</tt>, which has to be given in the
local coordinate system of <tt>frame_a</tt>.</p>

<p>All components of a 1D-rotational mechanical system that are connected to <b>a</b> common
<b>Mounting1D</b> element need to have the same axis of rotation
along parameter vector <tt>n</tt>. This means that, e.g., bevel
gears where the axis of rotation of <tt>flange_a</tt> and
<tt>flange_b</tt> are different cannot be described properly by
connecting to the <b>Mounting1D</b> component. In this case, a combination of several
<b>Mounting1D</b> components or the component <b>BevelGear1D</b> should be used.</p>

<p><b>Reference</b><br>
<span style=\"font-variant:small-caps\">Schweiger</span>, Christian ;
<span style=\"font-variant:small-caps\">Otter</span>, Martin:
<a href=\"http://www.modelica.org/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling
3D Mechanical Effects of 1D Powertrains</a>. In: <i>Proceedings of the 3rd International
Modelica Conference</i>. Link&ouml;ping : The Modelica Association and Link&ouml;ping University,
November 3-4, 2003, pp. 149-158</p>

</HTML>
"),
      Diagram(
        Polygon(points=[8, 46; -12, 51; -12, 41; 8, 46], style(color=10,
              fillColor=10)),
        Line(points=[-82, 46; -11, 46], style(color=10, fillColor=10)),
        Text(
          extent=[12, 53; 80, 40],
          string="rotation axis",
          style(color=10))));
  equation
    flange_b.phi = phi0;
    frame_a.f = zeros(3);
    frame_a.t = -n*flange_b.tau;
  end Mounting1D;

  model Rotor1D
    "1D inertia attachable on 3D bodies (without neglecting dynamic effects)"

    import SI = Modelica.SIunits;
    import Cv = Modelica.SIunits.Conversions;

    parameter Boolean animation=true
      "= true, if animation shall be enabled (show rotor as cylinder)";
    parameter Modelica.SIunits.Inertia J=1
      "Moment of inertia of rotor around its axis of rotation";
    parameter MultiBody.Types.Axis n={1,0,0}
      "Axis of rotation resolved in frame_a";
    parameter Types.Init.Temp initType=Types.Init.Free
      "|Initialization| Type of initialization (defines usage of start values below)";
    parameter Cv.NonSIunits.Angle_deg phi_start=0
      "|Initialization| Initial value of rotor rotation angle phi (fixed or guess value)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.AngularVelocity_degs w_start=0
      "|Initialization| Initial value of relative angular velocity w = der(phi)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.AngularAcceleration_degs2 a_start=0
      "|Initialization| Initial value of relative angular acceleration a = der(w)"
      annotation (Evaluate=false);
    parameter SI.Position r_center[3]=zeros(3)
      "|Animation|if animation = true| Position vector from origin of frame_a to center of cylinder";
    parameter SI.Distance cylinderLength=2*world.defaultJointLength
      "|Animation|if animation = true| Length of cylinder representing the rotor";
    parameter SI.Distance cylinderDiameter=2*world.defaultJointWidth
      "|Animation|if animation = true| Diameter of cylinder representing the rotor";
    parameter MultiBody.Types.Color cylinderColor=Types.Defaults.RodColor
      "|Animation|if animation = true| Color of cylinder representing the rotor";
    parameter Boolean enforceStates=false
      "|Advanced|| = true, if rotor angle (phi) and rotor speed (w) shall be used as states";
    parameter Boolean exact=true
      "|Advanced|| = true, if exact calculations; false if influence of bearing on rotor acceleration is neglected to avoid an algebraic loop";
    Modelica.SIunits.AngularVelocity w_a[3]
      "Angular velocity of frame_a, resolved in frame_a";
    SI.Angle phi(start=Cv.from_deg(phi_start), stateSelect=if enforceStates
           then StateSelect.always else StateSelect.default)
      "Rotation angle of rotor with respect to frame_a (= flange_a.phi = flange_b.phi)";
    SI.AngularVelocity w(stateSelect=if enforceStates then StateSelect.always
           else StateSelect.default)
      "Angular velocity of rotor with respect to frame_a";
    SI.AngularAcceleration a
      "Angular acceleration of rotor with respect to frame_a";

    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a
      "(left) driving flange (flange axis directed INTO cut plane)"
      annotation (extent=[-110, -10; -90, 10]);
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b
      "(right) driven flange (flange axis directed OUT OF cut plane)"
      annotation (extent=[90, -10; 110, 10]);
    MultiBody.Interfaces.Frame_a frame_a
      annotation (extent=[-15, -120; 15, -100], rotation=90);
    annotation (
      Documentation(info="<html>
<p>This component is used to model the gyroscopic torques exerted by a 1D
inertia (so called <i>rotor</i>) on its 3D carrier body. Gyroscopic torques
appear, if the vector of the carrier body's angular velocity is not parallel
to the vector of the rotor's. The axis of rotation of the rotor is defined by
the parameter <tt>n</tt>, which has to be given in the local coordinate system
of <tt>frame_a</tt>. The default animation of this component is
shown in the figure below. </p>

      <IMG SRC=\"../Images/Parts/Rotor1D.png\" ALT=\"model Parts.Rotor1D\">


<p>This component is a replacement for
<a href=\"Modelica://Modelica.Mechanics.Rotational.Inertia\">Modelica.Mechanics.Rotational.Inertia</a>
for the case, that a 1D-rotational mechanical system should be attached with a 3D
carrier body.</p>
<p>The Boolean parameter <tt>exact</tt> was introduced due to performance
reasons. If <tt>exact</tt> is set to true, the influence of the carrier body
motion on the angular velocity of the rotor is neglected. This influence is usually
negligible if the 1D-rotational mechanical system accelerates much faster as the base body (this is,
e.g., the case in vehicle powertrains). The essential advantage is
that an algebraic loop is removed since then there is only an
action on acceleration level from the powertrain to the base body
but not vice versa.</p>
<p><b>Reference</b><br>
<span style=\"font-variant:small-caps\">Schweiger</span>, Christian ;
<span style=\"font-variant:small-caps\">Otter</span>, Martin:
<a href=\"http://www.modelica.org/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling
3D Mechanical Effects of 1D Powertrains</a>. In: <i>Proceedings of the 3rd International
Modelica Conference</i>. Link&ouml;ping : The Modelica Association and Link&ouml;ping University,
November 3-4, 2003, pp. 149-158</p>
</HTML>
"),
      Icon(
        Line(points=[-80, -25; -60, -25], style(color=0)),
        Line(points=[60, -25; 80, -25], style(color=0)),
        Line(points=[-70, -25; -70, -70], style(color=0)),
        Line(points=[70, -25; 70, -70], style(color=0)),
        Line(points=[-80, 25; -60, 25], style(color=0)),
        Line(points=[60, 25; 80, 25], style(color=0)),
        Line(points=[-70, 45; -70, 25], style(color=0)),
        Line(points=[70, 45; 70, 25], style(color=0)),
        Line(points=[-70, -70; 70, -70], style(color=0)),
        Rectangle(extent=[-50, 50; 50, -50], style(
            color=0,
            gradient=2,
            fillColor=8)),
        Rectangle(extent=[-90, 10; -50, -10], style(
            color=0,
            gradient=2,
            fillColor=8)),
        Rectangle(extent=[50, 10; 90, -10], style(
            color=0,
            gradient=2,
            fillColor=8)),
        Text(extent=[0, 120; 0, 60], string="%name=%J"),
        Line(points=[0, -70; 0, -100], style(color=0))),
      Diagram(
        Line(points=[-80, -25; -60, -25], style(color=0)),
        Line(points=[60, -25; 80, -25], style(color=0)),
        Line(points=[-70, -25; -70, -70], style(color=0)),
        Line(points=[70, -25; 70, -70], style(color=0)),
        Line(points=[-80, 25; -60, 25], style(color=0)),
        Line(points=[60, 25; 80, 25], style(color=0)),
        Line(points=[-70, 45; -70, 25], style(color=0)),
        Line(points=[70, 45; 70, 25], style(color=0)),
        Line(points=[-70, -70; 70, -70], style(color=0)),
        Rectangle(extent=[-50, 50; 50, -50], style(
            color=0,
            gradient=2,
            fillColor=8)),
        Rectangle(extent=[-90, 10; -50, -10], style(
            color=0,
            gradient=2,
            fillColor=8)),
        Rectangle(extent=[50, 10; 90, -10], style(
            color=0,
            gradient=2,
            fillColor=8)),
        Polygon(points=[6, 88; -14, 93; -14, 83; 6, 88], style(color=10,
              fillColor=10)),
        Line(points=[-84, 88; -13, 88], style(color=10, fillColor=10)),
        Text(
          extent=[10, 95; 78, 82],
          string="rotation axis",
          style(color=10)),
        Polygon(points=[9, 73; 19, 70; 9, 67; 9, 73], style(color=0, fillColor=
                0)),
        Line(points=[9, 70; -21, 70], style(color=0, fillColor=0)),
        Text(extent=[25, 77; 77, 65], string="w = der(phi) "),
        Line(points=[0, -70; 0, -100], style(color=0))));

  protected
    outer MultiBody.World world;
    parameter Real e[3]=Frames.normalize(n)
      "Unit vector in direction of rotor axis, resolved in frame_a";
    parameter SI.Inertia nJ[3]=J*e;
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    Visualizers.Advanced.Shape cylinder[ndim](
      each shapeType="cylinder",
      each color=cylinderColor,
      each length=cylinderLength,
      each width=cylinderDiameter,
      each height=cylinderDiameter,
      each lengthDirection=n,
      each widthDirection={0,1,0},
      each extra=1,
      each r_shape=r_center - e*(cylinderLength/2),
      each r=frame_a.r_0,
      each R=Frames.absoluteRotation(frame_a.R, Frames.planarRotation(e, phi, 0)));

  initial equation
    if initType == Types.Init.PositionVelocity then
      phi = Cv.from_deg(phi_start);
      w = w_start*Modelica.Constants.D2R;
    elseif initType == Types.Init.SteadyState then
      w = 0;
      a = 0;
    elseif initType == Types.Init.Position then
      phi = Cv.from_deg(phi_start);
    elseif initType == Types.Init.Velocity then
      w = w_start*Modelica.Constants.D2R;
    elseif initType == Types.Init.VelocityAcceleration then
      w = w_start*Modelica.Constants.D2R;
      a = a_start*Modelica.Constants.D2R;
    elseif initType == Types.Init.PositionVelocityAcceleration then
      phi = Cv.from_deg(phi_start);
      w = w_start*Modelica.Constants.D2R;
      a = a_start*Modelica.Constants.D2R;
    end if;
  equation
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of Parts.Rotor1D object is not connected");

    phi = flange_a.phi;
    phi = flange_b.phi;
    w = der(phi);
    a = der(w);

    w_a = MultiBody.Frames.angularVelocity2(frame_a.R);
    if exact then
      J*a = flange_a.tau + flange_b.tau - nJ*der(w_a);
    else
      J*a = flange_a.tau + flange_b.tau;
    end if;
    frame_a.f = zeros(3);
    frame_a.t = nJ*a + cross(w_a, nJ*w);
  end Rotor1D;

  model BevelGear1D
    "1D gearbox with arbitrary shaft directions (3D bearing frame)"
    extends Modelica.Mechanics.Rotational.Interfaces.TwoFlanges;

    parameter Real ratio=1 "Gear speed ratio";
    parameter MultiBody.Types.Axis n_a={1,0,0}
      "Axis of rotation of flange_a, resolved in frame_a";
    parameter MultiBody.Types.Axis n_b={1,0,0}
      "Axis of rotation of flange_b, resolved in frame_a";

    MultiBody.Interfaces.Frame_a frame_a "Bearing frame"
      annotation (extent=[-15, -120; 15, -100], rotation=90);

    annotation (Icon(
        Rectangle(extent=[-40, 20; -20, -20], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 140; -20, 20], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[20, 100; 40, 60], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[20, 60; 40, -60], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[40, 10; 90, -10], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-20, 90; 20, 70], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-90, 10; -40, -10], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Text(extent=[0, 160; 0, 100], string="%name=%ratio"),
        Line(points=[-80, 20; -60, 20], style(color=0)),
        Line(points=[-80, -20; -60, -20], style(color=0)),
        Line(points=[-10, 100; 10, 100], style(color=0)),
        Line(points=[-10, 60; 10, 60], style(color=0)),
        Line(points=[60, 20; 80, 20], style(color=0)),
        Line(points=[60, -20; 80, -20], style(color=0)),
        Line(points=[-70, -20; -70, -70; 70, -70; 70, -20], style(color=0)),
        Line(points=[0, 60; 0, -70; 0, -100], style(color=0))), Documentation(
          info="<html>
<p>This component is used to model a 1D gearbox
with non-parallel axes (defined by parameters <tt>n_a</tt>, <tt>n_b</tt>).
A 3D <tt>bearing</tt> frame is necessary to reflect the
correct support torque, as the axes of rotation of <tt>flange_a</tt> and
<tt>flange_b</tT> and the direction of the support torque vector
are different in general.</p>
<p>Note: The name BevelGear1D is kept only for simplicity. Regardless,
this component could be used to model any kind of gearbox with non-parallel axes.</p>
<p><b>Reference</b><br>
<span style=\"font-variant:small-caps\">Schweiger</span>, Christian ;
<span style=\"font-variant:small-caps\">Otter</span>, Martin:
<a href=\"http://www.modelica.org/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling
3D Mechanical Effects of 1D Powertrains</a>. In: <i>Proceedings of the 3rd International
Modelica Conference</i>. Link&ouml;ping : The Modelica Association and Link&ouml;ping University,
November 3-4, 2003, pp. 149-158</p>
</html>"));
  protected
    parameter Real e_a[3]=MultiBody.Frames.normalize(n_a)
      "Unit vector in direction of flange_a rotation axis";
    parameter Real e_b[3]=MultiBody.Frames.normalize(n_b)
      "Unit vector in direction of flange_b rotation axis";
  equation
    flange_a.phi = ratio*flange_b.phi;
    0 = ratio*flange_a.tau + flange_b.tau;

    frame_a.f = zeros(3);
    frame_a.t = -flange_a.tau*e_a - flange_b.tau*e_b;
  end BevelGear1D;
end Parts;
