package Joints "Components that constrain the motion between two frames"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Library;

  annotation (preferedView="info", Documentation(info="<HTML>
<p>
This package contains <b>joint components</b>,
that is, idealized, massless elements that constrain
the motion between frames. In subpackage <b>Assemblies</b>
aggregation joint components are provided to handle
kinematic loops analytically (this means that non-linear systems
of equations occuring in these joint aggregations are analytically
solved, i.e., robustly and efficiently).
</p>

<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Model</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td><b><a href=\"Modelica:MultiBody.Joints.Prismatic\">Prismatic</a></b><br>
<b><a href=\"Modelica:MultiBody.Joints.ActuatedPrismatic\">ActuatedPrismatic</a></b></td>
      <td>Prismatic joint and actuated prismatic joint
          (1 translational degree-of-freedom, 2 potential states)<br>
      <IMG SRC=\"../Images/Joints/Prismatic.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica:MultiBody.Joints.Revolute\">Revolute</a></b><br>
  <b><a href=\"Modelica:MultiBody.Joints.ActuatedRevolute\">ActuatedRevolute</a></b>
 </td>
      <td>Revolute and actuated revolute joint
          (1 rotational degree-of-freedom, 2 potential states)<br>
      <IMG SRC=\"../Images/Joints/Revolute.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica:MultiBody.Joints.Cylindrical\">Cylindrical</a></b></td>
      <td>Cylindrical joint (2 degrees-of-freedom, 4 potential states)<br>
      <IMG SRC=\"../Images/Joints/Cylindrical.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica:MultiBody.Joints.Universal\">Universal</a></b></td>
      <td>Universal joint (2 degrees-of-freedom, 4 potential states)<br>
      <IMG SRC=\"../Images/Joints/Universal.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica:MultiBody.Joints.Planar\">Planar</a></b></td>
      <td>Planar joint (3 degrees-of-freedom, 6 potential states)<br>
      <IMG SRC=\"../Images/Joints/Planar.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica:MultiBody.Joints.Spherical\">Spherical</a></b></td>
      <td>Spherical joint (3 constraints and no potential states, or 3 degrees-of-freedom and 3 states)<br>
      <IMG SRC=\"../Images/Joints/Spherical.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica:MultiBody.Joints.FreeMotion\">FreeMotion</a></b></td>
      <td>Free motion joint (6 degrees-of-freedom, 12 potential states)<br>
      <IMG SRC=\"../Images/Joints/FreeMotion.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica:MultiBody.Joints.SphericalSpherical\">SphericalSpherical</a></b></td>
      <td>Spherical - spherical joint aggregation (1 constraint,
          no potential states) with an optional point mass in the middle<br>
      <IMG SRC=\"../Images/Joints/SphericalSpherical.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica:MultiBody.Joints.UniversalSpherical\">UniversalSpherical</a></b></td>
      <td>Universal - spherical joint aggregation (1 constraint, no potential states)<br>
      <IMG SRC=\"../Images/Joints/UniversalSpherical.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica:MultiBody.Joints.GearConstraint\">GearConstraint</a></b></td>
      <td>Ideal 3D gearbox (arbitrary shaft directions)
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica:MultiBody.Joints.Assemblies\">MultiBody.Joints.Assemblies</a></b></td>
      <td><b>Package</b> of joint aggregations for analytic loop handling.
      </td>
  </tr>
</table>

</HTML>"));

  model Prismatic
    "Prismatic joint (1 translational degree-of-freedom, 2 potential states)"

    extends Internal.Prismatic;

    annotation (
      preferedView="info",
      Icon(Text(
          extent=[-142, 62; 147, 101],
          string="n=%n",
          style(color=0)), Text(extent=[-135, -117; 141, -60], string="%name")),

      Documentation(info="<HTML>
<p>
Joint where frame_b is translated along axis n which is fixed in frame_a.
The two frames coincide when \"s + s_offset = 0\", where
\"s_offset\" is a parameter with a zero default
and \"s\" is the relative distance.
</p>
<p>
In the \"Advanced\" menu it can be defined via parameter <b>enforceStates</b>
that the relative distance \"s\" and its derivative shall be definitely
used as states (this means that the Modelica attributes stateSelect=StateSelect.always
are set on these variables). The states are usually selected automatically.
In certain situations, especially when closed kinematic loops are present,
it might be slightly more efficient, when using the \"enforceStates\" setting.
</p>

<p>
In the following figure the animation of a prismatic
joint is shown. The light blue coordinate system is
frame_a and the dark blue coordinate system is
frame_b of the joint. The black arrow is parameter
vector \"n\" defining the translation axis
(here: n = {1,1,0}).
</p>

<p align=\"center\">
<IMG SRC=\"../Images/Joints/Prismatic.png\">
</p>
</HTML>
"));

  end Prismatic;

  model ActuatedPrismatic
    "Actuated prismatic joint (1 translational degree-of-freedom, 2 potential states)"


    extends Internal.Prismatic(final f=axis.f);
    Modelica.Mechanics.Translational.Interfaces.Flange_a axis
      annotation (extent=[70, 70; 90, 50]);
    Modelica.Mechanics.Translational.Interfaces.Flange_b bearing
      annotation (extent=[-30, 70; -50, 50]);
    annotation (
      preferedView="info",
      Diagram(
        Text(extent=[42, 81; 57, 66], string="f"),
        Line(points=[40, 65; 70, 65], style(color=3)),
        Polygon(points=[-20, 68; -30, 65; -20, 62; -20, 68], style(color=3,
              fillColor=3)),
        Line(points=[-8, 65; -31, 65], style(color=3)),
        Text(extent=[-20, 80; -5, 65], string="f"),
        Polygon(points=[60, 68; 70, 65; 60, 62; 60, 68], style(color=3,
              fillColor=3)),
        Rectangle(extent=[90, 30; 100, 70], style(pattern=0, fillColor=8)),
        Line(points=[-30, 54; 70, 54], style(color=10)),
        Polygon(points=[60, 57; 70, 54; 60, 51; 60, 57], style(color=10,
              fillColor=10)),
        Text(
          extent=[0, 53; 37, 40],
          style(color=10),
          string="s")),
      Coordsys(grid=[1, 1], component=[20, 20]),
      Icon(
        Rectangle(extent=[90, 30; 100, 70], style(pattern=0, fillColor=8)),
        Text(
          extent=[-141, -92; 148, -53],
          string="n=%n",
          style(color=0)),
        Text(extent=[-132, -153; 144, -96], string="%name")),
      Documentation(info="<HTML>
<p>
Joint where frame_b is translated along axis n which is fixed in frame_a.
The two frames coincide when \"s + s_offset = 0\", where
\"s_offset\" is a parameter with a zero default
and \"s\" is the relative distance.
</p>
<p>
The prismatic joint has two additional 1-dimensional mechanical flanges
(flange \"axis\" represents the driving flange and
flange \"bearing\" represents the bearing) where it can be
driven with elements of the Modelica.Mechanics.Translational library.
</p>
<p>
In the \"Advanced\" menu it can be defined via parameter <b>enforceStates</b>
that the relative distance \"s\" and its derivative shall be definitely
used as states (this means that the Modelica attributes stateSelect=StateSelect.always
are set on these variables). The states are usually selected automatically.
In certain situations, especially when closed kinematic loops are present,
it might be slightly more efficient, when using the \"enforceStates\" setting.
</p>

<p>
In the following figure the animation of an actuated
prismatic
joint is shown. The light blue coordinate system is
frame_a and the dark blue coordinate system is
frame_b of the joint. The black arrow is parameter
vector \"n\" defining the translation axis
(here: n = {1,1,0}).
</p>

<p align=\"center\">
<IMG SRC=\"../Images/Joints/Prismatic.png\">
</p>
</HTML>
"));
  equation
    axis.s = s;
    bearing.s = 0;
  end ActuatedPrismatic;

  model Revolute
    "Revolute joint (1 rotational degree-of-freedom, 2 potential states)"

    extends Internal.Revolute;
    annotation (
      preferedView="info",
      Icon(Text(
          extent=[-146, 70; 143, 109],
          string="n=%n",
          style(color=0)), Text(extent=[-137, -125; 139, -68], string="%name")),

      Documentation(info="<HTML>
<p>
Joint where frame_b rotates around axis n which is fixed in frame_a.
The two frames coincide when \"phi + phi_offset = 0\", where
\"phi_offset\" is a parameter with a zero default
and \"phi\" is the rotation angle.
</p>
<p>
In the \"Advanced\" menu it can be defined via parameter <b>enforceStates</b>
that the rotation angle \"phi\" and its derivative shall be definitely
used as states (this means that the Modelica attributes stateSelect=StateSelect.always
are set on these variables). The states are usually selected automatically.
In certain situations, especially when closed kinematic loops are present,
it might be slightly more efficient, when using the \"enforceStates\" setting.
</p>
<p>
If a <b>planar loop</b> is present, e.g., consisting of 4 revolute joints
where the joint axes are all parallel to each other, then there is no
longer a unique mathematical solution and the symbolic algorithms will
fail. Usually, an error message will be printed pointing out this
situation. In this case, parameter <b>planarCutJoint</b> in the \"Advanced\"
menu of one of the revolute joints has to be set to <b>true</b>. The
effect is that from the 5 constraints of a usual revolute joint,
3 constraints are removed and replaced by appropriate known
variables (e.g., the force in the direction of the axis of rotation is
treated as known with value equal to zero; for standard revolute joints,
this force is an unknown quantity).
</p>

<p>
In the following figure the animation of a revolute
joint is shown. The light blue coordinate system is
frame_a and the dark blue coordinate system is
frame_b of the joint. The black arrow is parameter
vector \"n\" defining the translation axis
(here: n = {0,0,1}, phi_start = 45<sup>o</sup>).
</p>

<p align=\"center\">
<IMG SRC=\"../Images/Joints/Revolute.png\">
</p>
</HTML>"));

  end Revolute;

  model ActuatedRevolute
    "Actuated revolute joint (1 rotational degree-of-freedom, 2 potential states)"


    extends Internal.Revolute(final tau=axis.tau);
    Modelica.Mechanics.Rotational.Interfaces.Flange_a axis
      annotation (extent=[10, 110; -10, 90]);
    Modelica.Mechanics.Rotational.Interfaces.Flange_b bearing
      annotation (extent=[-70, 110; -50, 90]);
    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.05,
        y=0.09,
        width=0.65,
        height=0.69),
      Icon(
        Rectangle(extent=[-30, 61; 30, -60], style(color=7, fillColor=7)),
        Line(points=[-20, 70; -60, 70], style(color=0)),
        Line(points=[-20, 80; -20, 60], style(color=0)),
        Line(points=[20, 80; 20, 60], style(color=0)),
        Line(points=[20, 70; 41, 70], style(color=0)),
        Rectangle(extent=[-10, 90; 10, 50], style(
            color=8,
            gradient=1,
            fillColor=8)),
        Polygon(points=[-10, 30; 10, 30; 30, 50; -30, 50; -10, 30], style(
            color=0,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-100, 60; -30, -60], style(color=0)),
        Line(points=[-60, 60; -60, 90], style(color=0)),
        Rectangle(extent=[-30, 11; 10, -10], style(
            color=0,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[10, 30; 30, 50; 30, -50; 10, -30; 10, 30], style(color=
                0, fillColor=8)),
        Rectangle(extent=[-100, 60; -30, -60], style(color=0)),
        Rectangle(extent=[30, 60; 100, -60], style(color=0)),
        Text(
          extent=[-140, -105; 149, -66],
          string="n=%n",
          style(color=0)),
        Text(extent=[-138, -166; 138, -109], string="%name")),
      Diagram(
        Rectangle(extent=[-29, 60; 29, -62], style(color=7, fillColor=7)),
        Line(points=[-60, 60; -60, 90], style(color=0)),
        Line(points=[-20, 70; -60, 70], style(color=0)),
        Line(points=[-20, 80; -20, 60], style(color=0)),
        Rectangle(extent=[-10, 90; 10, 50], style(
            color=8,
            gradient=1,
            fillColor=8)),
        Line(points=[20, 80; 20, 60], style(color=0)),
        Line(points=[20, 70; 41, 70], style(color=0)),
        Polygon(points=[-10, 30; 10, 30; 30, 50; -30, 50; -10, 30], style(
            color=0,
            fillColor=8,
            fillPattern=1)),
        Polygon(points=[10, 30; 30, 50; 30, -50; 10, -30; 10, 30], style(color=
                0, fillColor=8)),
        Rectangle(extent=[-30, 11; 10, -10], style(
            color=0,
            gradient=0,
            fillColor=8,
            fillPattern=1))),
      Documentation(info="<HTML>
<p>
Joint where frame_b rotates around axis n which is fixed in frame_a.
The two frames coincide when \"phi + phi_offset = 0\", where
\"phi_offset\" is a parameter with a zero default
and \"phi\" is the rotation angle.
</p>
<p>
The revolute joint has two additional 1-dimensional mechanical flanges
(flange \"axis\" represents the driving flange and
flange \"bearing\" represents the bearing) where it can be
driven with elements of the Modelica.Mechanics.Rotational library.
</p>
<p>
In the \"Advanced\" menu it can be defined via parameter <b>enforceStates</b>
that the rotation angle \"phi\" and its derivative shall be definitely
used as states (this means that the Modelica attributes stateSelect=StateSelect.always
are set on these variables). The states are usually selected automatically.
In certain situations, especially when closed kinematic loops are present,
it might be slightly more efficient, when using the \"enforceStates\" setting.
</p>
<p>
If a <b>planar loop</b> is present, e.g., consisting of 4 revolute joints
where the joint axes are all parallel to each other, then there is no
longer a unique mathematical solution and the symbolic algorithms will
fail. Usually, an error message will be printed pointing out this
situation. In this case, parameter <b>planarCutJoint</b> in the \"Advanced\"
menu of one of the revolute joints has to be set to <b>true</b>. The
effect is that from the 5 constraints of a usual revolute joint,
3 constraints are removed and replaced by appropriate known
variables (e.g., the force in the direction of the axis of rotation is
treated as known with value equal to zero; for standard revolute joints,
this force is an unknown quantity).
</p>

<p>
In the following figure the animation of an actuated revolute
joint is shown. The light blue coordinate system is
frame_a and the dark blue coordinate system is
frame_b of the joint. The black arrow is parameter
vector \"n\" defining the translation axis
(here: n = {0,0,1}, phi_start = 45<sup>o</sup>).
</p>

<p align=\"center\">
<IMG SRC=\"../Images/Joints/Revolute.png\">
</p>
</HTML>"));
  equation
    axis.phi = phi;
    bearing.phi = 0;
  end ActuatedRevolute;

  model Cylindrical
    "Cylindrical joint (2 degrees-of-freedom, 4 potential states)"
    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    extends MultiBody.Interfaces.PartialTwoFrames;
    parameter Boolean animation=true
      "= true, if animation shall be enabled (show cylinder)";
    parameter MultiBody.Types.Axis n={1,0,0}
      "Cylinder axis resolved in frame_a (= same as in frame_b)"
      annotation (Evaluate=true);
    parameter Types.Init.Temp initType=Types.Init.Free
      "|Initialization| Type of initialization (defines usage of start values below)";
    parameter NonSI.Angle_deg phi_start=0
      "|Initialization| Initial value of rotation angle phi (fixed or guess value)"
      annotation (Evaluate=false);
    parameter SI.Position s_start=0
      "|Initialization| Initial value of relative distance (fixed or guess value)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.AngularVelocity_degs w_start=0
      "|Initialization| Initial value of relative angular velocity w = der(phi)"
      annotation (Evaluate=false);
    parameter SI.Velocity v_start=0
      "|Initialization| Initial value of relative velocity v = der(s)"
      annotation (Evaluate=false);
    parameter SI.Acceleration a_start=0
      "|Initialization| Initial value of relative acceleration a = der(v)"
      annotation (Evaluate=false);
    parameter MultiBody.Types.AngularAcceleration_degs2 wd_start=0
      "|Initialization| Initial value of relative angular acceleration wd = der(w)"
      annotation (Evaluate=false);
    parameter SI.Distance cylinderDiameter=world.defaultJointWidth
      "|Animation|if animation = true| Diameter of cylinder";
    parameter MultiBody.Types.Color cylinderColor=Types.Defaults.JointColor
      "|Animation|if animation = true| Color of cylinder";
    parameter Boolean enforceStates=false
      "|Advanced|| = true, if generalized variables shall be used as states";
    Prismatic prismatic(
      n=n,
      animation=false,
      enforceStates=enforceStates,
      initType=initType,
      s_start=s_start,
      v_start=v_start,
      a_start=a_start) annotation (extent=[-70, -25; -15, 25]);
    Revolute revolute(
      n=n,
      animation=false,
      enforceStates=enforceStates,
      initType=initType,
      phi_start=phi_start,
      w_start=w_start,
      a_start=wd_start) annotation (extent=[10, -25; 65, 25]);
    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.33,
        y=0.08,
        width=0.67,
        height=0.7),
      Documentation(info="<HTML>
<p>
Joint where frame_b rotates around and translates along axis n
which is fixed in frame_a. The two frames coincide when
\"revolute.phi=0\" and \"prismatic.s=0\". This joint
has the following potential states;
<ul>
<li> The relative angle revolute.phi [rad] around axis n, </li>
<li> the relative distance prismatic.s [m] along axis n, </li>
<li> the relative angular velocity revolute.w [rad/s] (= der(revolute.phi))
     and </li>
<li> the relative velocity prismatic.v [m/s] (= der(prismatic.s)).</li>
</ul>
<p>
They are used as candidates for automatic selection of states
from the tool. This may be enforced by setting \"enforceStates=<b>true</b>\"
in the <b>Advanced</b> menu (this means that the Modelica
attributes stateSelect=StateSelect.always
are set on these variables). The states are usually selected automatically.
In certain situations, especially when closed kinematic loops are present,
it might be slightly more efficient, when using the \"enforceStates\" setting.
</p>

<p>
In the following figure the animation of a cylindrical
joint is shown. The light blue coordinate system is
frame_a and the dark blue coordinate system is
frame_b of the joint. The black arrow is parameter
vector \"n\" defining the cylinder axis
(here: n = {0,0,1}).
</p>

<p align=\"center\">
<IMG SRC=\"../Images/Joints/Cylindrical.png\">
</p>
</HTML>
"),
      Icon(
        Rectangle(extent=[-100, -50; 0, 50], style(
            color=0,
            gradient=2,
            fillColor=8)),
        Rectangle(extent=[0, -30; 100, 30], style(
            color=0,
            gradient=2,
            fillColor=8)),
        Line(points=[0, -50; 0, 50], style(color=0)),
        Text(extent=[-126, 116; 134, 56], string="%name"),
        Text(
          extent=[-118, -65; 120, -102],
          string="n=%n",
          style(color=0))));

  protected
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
  protected
    Visualizers.Advanced.Shape cylinder[ndim](
      each shapeType="cylinder",
      each color=cylinderColor,
      each length=prismatic.s,
      each width=cylinderDiameter,
      each height=cylinderDiameter,
      each lengthDirection=prismatic.n,
      each widthDirection={0,1,0},
      each r=frame_a.r_0,
      each R=frame_a.R) annotation (extent=[-10, 40; 10, 60]);
  equation
    connect(frame_a, prismatic.frame_a)
      annotation (points=[-110, 0; -72.75, 0], style(color=0, thickness=2));
    connect(prismatic.frame_b, revolute.frame_a)
      annotation (points=[-12.25, 0; 7.25, 0], style(color=0, thickness=2));
    connect(revolute.frame_b, frame_b)
      annotation (points=[67.75, 0; 110, 0], style(color=0, thickness=2));
  end Cylindrical;

  model Universal "Universal joint (2 degrees-of-freedom, 4 potential states)"
    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    extends MultiBody.Interfaces.PartialTwoFrames;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter MultiBody.Types.Axis n_a={1,0,0}
      "Axis of revolute joint 1 resolved in frame_a" annotation (Evaluate=true);
    parameter MultiBody.Types.Axis n_b={0,1,0}
      "Axis of revolute joint 2 resolved in frame_b" annotation (Evaluate=true);

    parameter Types.Init.Temp initType=Types.Init.Free
      "|Initialization| Type of initialization (defines usage of start values below)";
    parameter NonSI.Angle_deg phi_start_a=0
      "|Initialization| Initial value of rotation angle at frame_a (fixed or guess value)";
    parameter NonSI.Angle_deg phi_start_b=0
      "|Initialization| Initial value of rotation angle at frame_b (fixed or guess value)";
    parameter MultiBody.Types.AngularVelocity_degs w_start_a=0
      "|Initialization| Initial value of derivative of rotation angle at frame_a";
    parameter MultiBody.Types.AngularVelocity_degs w_start_b=0
      "|Initialization| Initial value of derivative of rotation angle at frame_b";
    parameter MultiBody.Types.AngularAcceleration_degs2 a_start_a=0
      "|Initialization| Initial value of second derivative of rotation angle at frame_a";
    parameter MultiBody.Types.AngularAcceleration_degs2 a_start_b=0
      "|Initialization| Initial value of second derivative of rotation angle at frame_b";

    parameter SI.Distance cylinderLength=world.defaultJointLength
      "|Animation|if animation = true| Length of cylinders representing the joint axes";
    parameter SI.Distance cylinderDiameter=world.defaultJointWidth
      "|Animation|if animation = true| Diameter of cylinders representing the joint axes";
    parameter MultiBody.Types.Color cylinderColor=Types.Defaults.JointColor
      "|Animation|if animation = true| Color of cylinders representing the joint axes";
    parameter Boolean enforceStates=false
      "|Advanced|| = true, if generalized variables shall be used as states";
    MultiBody.Joints.Revolute revolute_a(
      n=n_a,
      enforceStates=enforceStates,
      initType=initType,
      phi_start=phi_start_a,
      w_start=w_start_a,
      a_start=a_start_a,
      cylinderDiameter=cylinderDiameter,
      cylinderLength=cylinderLength,
      cylinderColor=cylinderColor,
      animation=animation) annotation (extent=[-60, -25; -10, 25]);
    MultiBody.Joints.Revolute revolute_b(
      n=n_b,
      enforceStates=enforceStates,
      initType=initType,
      phi_start=phi_start_b,
      w_start=w_start_b,
      a_start=a_start_b,
      animation=animation,
      cylinderDiameter=cylinderDiameter,
      cylinderLength=cylinderLength,
      cylinderColor=cylinderColor)
      annotation (extent=[10, 20; 60, 70], rotation=90);
    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.11,
        y=0.09,
        width=0.65,
        height=0.77),
      Documentation(info="<HTML>
<p>
Joint where frame_a rotates around axis n_a which is fixed in frame_a
and frame_b rotates around axis n_b which is fixed in frame_b.
The two frames coincide when
\"revolute_a.phi=0\" and \"revolute_b.phi=0\". This joint
has the following potential states;
<ul>
<li> The relative angle revolute_a.phi [rad] around axis n_a, </li>
<li> the relative angle revolute_b.phi [rad] around axis n_b, </li>
<li> the relative angular velocity revolute_a.w [rad/s] (= der(revolute_a.phi))
     and </li>
<li> the relative angular velocity revolute_b.w [rad/s] (= der(revolute_b.phi)).</li>
</ul>
<p>
They are used as candidates for automatic selection of states
from the tool. This may be enforced by setting \"enforceStates=<b>true</b>\"
in the <b>Advanced</b> menu (this means that the Modelica
attributes stateSelect=StateSelect.always
are set on these variables). The states are usually selected automatically.
In certain situations, especially when closed kinematic loops are present,
it might be slightly more efficient, when using the \"enforceStates\" setting.
</p>

<p>
In the following figure the animation of a universal
joint is shown. The light blue coordinate system is
frame_a and the dark blue coordinate system is
frame_b of the joint
(here: n_a = {0,0,1}, n_b = {0,1,0}, phi_start_a = 90<sup>o</sup>,
phi_start_b = 45<sup>o</sup>).
</p>

<p align=\"center\">
<IMG SRC=\"../Images/Joints/Universal.png\">
</p>

</HTML>"),
      Icon(
        Rectangle(extent=[-100, 15; -65, -15], style(
            color=1,
            gradient=2,
            fillColor=30)),
        Ellipse(extent=[-80, -80; 80, 80], style(color=9, fillColor=8)),
        Ellipse(extent=[-60, -60; 60, 60], style(
            color=9,
            fillColor=7,
            fillPattern=1)),
        Text(extent=[-134, -70; 126, -130], string="%name"),
        Rectangle(extent=[12, 82; 80, -82], style(color=7, fillColor=7)),
        Rectangle(extent=[56, 15; 100, -15], style(
            color=9,
            gradient=2,
            fillColor=30)),
        Line(points=[12, 78; 12, -78], style(
            color=0,
            thickness=2,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[-52, -40; 80, 40], style(color=9, fillColor=8)),
        Ellipse(extent=[-32, -20; 60, 26], style(
            color=9,
            fillColor=7,
            fillPattern=1)),
        Polygon(points=[-22, -54; -60, 0; -22, 50; 40, 52; -22, -54], style(
            pattern=0,
            fillColor=7,
            fillPattern=1)),
        Line(points=[12, 78; 12, -20], style(
            color=0,
            thickness=2,
            fillColor=7,
            fillPattern=1)),
        Line(points=[32, 38; -12, -36], style(
            color=0,
            thickness=2,
            fillColor=7,
            fillPattern=1))),
      Diagram);
  equation

    connect(frame_a, revolute_a.frame_a)
      annotation (points=[-110, 0; -62.5, 0], style(color=0, thickness=2));
    connect(revolute_b.frame_b, frame_b) annotation (points=[35, 72.5; 35, 90;
          70, 90; 70, 0; 110, 0], style(color=0, thickness=2));
    connect(revolute_a.frame_b, revolute_b.frame_a) annotation (points=[-7.5, 0;
           35, 0; 35, 17.5], style(color=0, thickness=2));
  end Universal;

  model Planar "Planar joint (3 degrees-of-freedom, 6 potential states)"
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    extends MultiBody.Interfaces.PartialTwoFrames;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter MultiBody.Types.Axis n={0,0,1}
      "Axis orthogonal to unconstrained plane, resolved in frame_a (= same as in frame_b)"
      annotation (Evaluate=true);
    parameter MultiBody.Types.Axis n_x={1,0,0}
      "Vector in direction of x-axis of plane, resolved in frame_a (n_x shall be orthogonal to n)"
      annotation (Evaluate=true);

    parameter Types.Init.Temp initType=Types.Init.Free
      "|Initialization| Type of initialization (defines usage of start values below)";
    parameter SI.Position s_start_x=0
      "|Initialization| Initial value of x-distance (along n_x; fixed or guess value)";
    parameter SI.Position s_start_y=0
      "|Initialization| Initial value of y-distance (along cross(n,n_x); fixed or guess value)";
    parameter NonSI.Angle_deg phi_start=0
      "|Initialization| Initial value of rotation angle along n (fixed or guess value)";
    parameter SI.Velocity v_start_x=0
      "|Initialization| Initial value of derivative of x-distance";
    parameter SI.Velocity v_start_y=0
      "|Initialization| Initial value of derivative of y-distance";
    parameter MultiBody.Types.AngularVelocity_degs w_start=0
      "|Initialization| Initial value of derivative of rotation angle";
    parameter SI.Acceleration a_start_x=0
      "|Initialization| Initial value of second derivative of x-distance";
    parameter SI.Acceleration a_start_y=0
      "|Initialization| Initial value of second derivative of y-distance";
    parameter MultiBody.Types.AngularAcceleration_degs2 wd_start=0
      "|Initialization| Initial value of second derivative of rotation angle";
    parameter SI.Distance cylinderLength=world.defaultJointLength
      "|Animation|if animation = true| Length of revolute cylinder";
    parameter SI.Distance cylinderDiameter=world.defaultJointWidth
      "|Animation|if animation = true| Diameter of revolute cylinder";
    parameter MultiBody.Types.Color cylinderColor=Types.Defaults.JointColor
      "|Animation|if animation = true| Color of revolute cylinder";
    parameter Real boxWidth=0.3*cylinderDiameter
      "|Animation|if animation = true| Width of prismatic joint boxes";
    parameter Real boxHeight=boxWidth
      "|Animation|if animation = true| Height of prismatic joint boxes";
    parameter MultiBody.Types.Color boxColor=Types.Defaults.JointColor
      "|Animation|if animation = true| Color of prismatic joint boxes";
    parameter Boolean enforceStates=false
      "|Advanced|| = true, if generalized variables (s,phi,v,w) shall be used as states";
    Prismatic prismatic_x(
      enforceStates=enforceStates,
      n=(cross(cross(n, n_x), n)),
      animation=false,
      initType=initType,
      s_start=s_start_x,
      v_start=v_start_x,
      a_start=a_start_x) annotation (extent=[-69, -20; -29, 20]);
    Prismatic prismatic_y(
      enforceStates=enforceStates,
      n=(cross(n, n_x)),
      animation=false,
      initType=initType,
      s_start=s_start_y,
      v_start=v_start_y,
      a_start=a_start_y) annotation (extent=[-20, 30; 20, 70], rotation=90);
    Revolute revolute(
      enforceStates=enforceStates,
      n=n,
      animation=false,
      initType=initType,
      phi_start=phi_start,
      w_start=w_start,
      a_start=wd_start) annotation (extent=[41, -20; 81, 20]);
    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.17,
        y=0.04,
        width=0.74,
        height=0.81),
      Documentation(info="<HTML>
<p>
Joint where frame_b can move in a plane and can rotate around an
axis orthogonal to the plane. The plane is defined by
vector n which is perpendicular to the plane and by vector n_x,
which points in the direction of the x-axis of the plane.
frame_a and frame_b coincide when prismatic_a.s=0,
prismatic_b=0 and revolute.phi=0. This joint has the following
potential states:
<ul>
<li> the relative distance prismatic_x.s [m] along axis n_x, </li>
<li> the relative distance prismatic_y.s [m] along axis n_y = cross(n,n_x), </li>
<li> the relative angle revolute.phi [rad] around axis n, </li>
<li> the relative velocity prismatic_x.v [m/s] (= der(prismatic_x.s)).</li>
<li> the relative velocity prismatic_y.v [m/s] (= der(prismatic_y.s)).</li>
<li> the relative angular velocity revolute.w [rad/s] (= der(revolute.phi))</li>
</ul>
<p>
The potential states are used as candidates for automatic selection of states
from the tool. This may be enforced by setting \"enforceStates=<b>true</b>\"
in the <b>Advanced</b> menu (this means that the Modelica
attributes stateSelect=StateSelect.always
are set on these variables). The states are usually selected automatically.
In certain situations, especially when closed kinematic loops are present,
it might be slightly more efficient, when using the \"enforceStates\" setting.
</p>
<p>
In the following figure the animation of a planar
joint is shown. The light blue coordinate system is
frame_a and the dark blue coordinate system is
frame_b of the joint. The black arrows are parameter
vectors \"n\" and \"n_x\"
(here: n = {0,1,0}, n_x = {0,0,1}, s_start_x = 0.5,
s_start_y = 0.5, phi_start = 45<sup>o</sup>).
</p>

<p align=\"center\">
<IMG SRC=\"../Images/Joints/Planar.png\">
</p>

</HTML>
"),
      Icon(
        Rectangle(extent=[-30, -60; -10, 60], style(
            color=0,
            pattern=0,
            fillColor=8)),
        Rectangle(extent=[10, -60; 30, 60], style(
            color=0,
            pattern=0,
            fillColor=8)),
        Rectangle(extent=[-100, -10; -30, 10], style(
            color=0,
            pattern=0,
            fillColor=8)),
        Rectangle(extent=[100, -10; 30, 10], style(
            color=0,
            pattern=0,
            fillColor=8)),
        Text(
          extent=[-131, -74; 133, -112],
          string="n=%n",
          style(color=0)),
        Text(extent=[-124, 127; 136, 67], string="%name")));

  protected
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    parameter Real e[3]=Frames.normalize(n);
  protected
    Visualizers.Advanced.Shape box_x[ndim](
      each shapeType="box",
      each color=boxColor,
      each length=prismatic_x.s,
      each width=boxWidth,
      each height=boxWidth,
      each lengthDirection=prismatic_x.e,
      each widthDirection={0,1,0},
      each r=frame_a.r_0,
      each R=frame_a.R) annotation (extent=[-80, 30; -60, 50]);
    Visualizers.Advanced.Shape box_y[ndim](
      each shapeType="box",
      each color=boxColor,
      each length=prismatic_y.s,
      each width=boxWidth,
      each height=boxWidth,
      each lengthDirection=prismatic_y.e,
      each widthDirection={1,0,0},
      each r=prismatic_y.frame_a.r_0,
      each R=prismatic_y.frame_a.R) annotation (extent=[-46, 69; -26, 89]);
    Visualizers.Advanced.Shape cylinder[ndim](
      each shapeType="cylinder",
      each color=cylinderColor,
      each length=cylinderLength,
      each width=cylinderDiameter,
      each height=cylinderDiameter,
      each lengthDirection=n,
      each widthDirection={0,1,0},
      each r_shape=-e*(cylinderLength/2),
      each r=revolute.frame_b.r_0,
      each R=revolute.frame_b.R) annotation (extent=[50, 30; 70, 50]);
  equation
    connect(frame_a, prismatic_x.frame_a)
      annotation (points=[-110, 0; -71, 0], style(color=0, thickness=2));
    connect(prismatic_x.frame_b, prismatic_y.frame_a) annotation (points=[-27,
          0; -1.34707e-015, 0; -1.34707e-015, 28], style(color=0, thickness=2));
    connect(prismatic_y.frame_b, revolute.frame_a) annotation (points=[
          1.34707e-015, 72; 0, 80; 30, 80; 30, 0; 39, 0], style(color=0,
          thickness=2));
    connect(revolute.frame_b, frame_b)
      annotation (points=[83, 0; 110, 0], style(color=0, thickness=2));
  end Planar;

  model Spherical
    "Spherical joint (3 constraints and no potential states, or 3 degrees-of-freedom and 3 states)"


    import MultiBody.Frames;
    import SI = Modelica.SIunits;
    import Cv = Modelica.SIunits.Conversions;

    extends MultiBody.Interfaces.PartialTwoFrames;
    parameter Boolean animation=true
      "= true, if animation shall be enabled (show sphere)";
    parameter SI.Distance sphereDiameter=world.defaultJointLength
      "|if animation = true| Diameter of sphere representing the spherical joint";
    parameter MultiBody.Types.Color sphereColor=Types.Defaults.JointColor
      "|if animation = true| Color of sphere representing the spherical joint";
    parameter Types.Init.Temp initType=Types.Init.Free
      "|Initialization|| Type of initialization (defines usage of start values below)";
    parameter MultiBody.Types.RotationSequence sequence_start={1,2,3}
      "|Initialization|| Sequence of rotations to rotate frame_a into frame_b at initial time"
      annotation (Evaluate=true);
    parameter Cv.NonSIunits.Angle_deg angles_start[3]={0,0,0}
      "|Initialization|| Initial values of angles to rotate frame_a around 'sequence_start' axes into frame_b"
      annotation (Evaluate=false);
    parameter MultiBody.Types.AngularVelocity_degs w_rel_a_start[3]={0,0,0}
      "|Initialization|| Initial values of angular velocity of frame_b with respect to frame_a, resolved in frame_a"
      annotation (Evaluate=false);
    parameter MultiBody.Types.AngularAcceleration_degs2 z_rel_a_start[3]={0,0,0}

      "|Initialization|| Initial values of angular acceleration z_rel = der(w_rel)"
      annotation (Evaluate=false);

    parameter Boolean enforceStates=false
      " = true, if relative variables of spherical joint shall be used as states"
      annotation (Dialog(tab="Advanced"));
    parameter Boolean useQuaternions=true
      " = true, if quaternions shall be used as states otherwise use 3 angles as states (provided enforceStates=true)"
      annotation (Dialog(tab="Advanced", enable=enforceStates));
    parameter Types.RotationSequence sequence_angleStates={1,2,3}
      " Sequence of rotations to rotate frame_a into frame_b around the 3 angles used as states"
       annotation (Evaluate=true, Dialog(tab="Advanced", enable=enforceStates
             and not useQuaternions));

    final parameter Frames.Orientation R_rel_start=
        MultiBody.Frames.axesRotations(sequence_start, Cv.from_deg(angles_start),
         zeros(3)) "Orientation object from frame_a to frame_b at initial time";
    final parameter SI.AngularVelocity w_rel_start_rad[3]=
        MultiBody.Frames.resolve2(R_rel_start, w_rel_a_start*Modelica.Constants
        .D2R);
    final parameter SI.AngularAcceleration z_rel_start_rad[3]=
        MultiBody.Frames.resolve2(R_rel_start, z_rel_a_start*Modelica.Constants
        .D2R);
    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.23,
        y=0.03,
        width=0.69,
        height=0.7),
      Documentation(info="<html>
<p>
Joint with <b>3 constraints</b> that define that the origin of
frame_a and the origin of frame_b coincide. By default this joint
defines only the 3 constraints without any potential states.
If parameter <b>enforceStates</b> is set to <b>true</b>
in the \"Advanced\" menu, three states are introduced.
Depending on parameter <b>useQuaternions</b> these are either
quaternions and the relative angular velocity or 3 angles
and the angle derivatves. In the latter case the orientation
of frame_b is computed by rotating frame_a along the axes defined
in parameter vector \"sequence_angleStates\" (default = {1,2,3}, i.e.,
the Cardan angle sequence) around the angles used as states.
For example, the default is to rotate the x-axis of frame_a
around angles[1], the new y-axis around angles[2] and the new z-axis
around angles[3], arriving at frame_b. If angles are used
as states there is the slight disadvantage that
a singular configuration is present leading to a divison by zero.
</p>
<p>
If this joint is used in a <b>chain</b> structure, a Modelica translator
has to select orientation coordinates of a body as states, if the
default setting is used. It is usually better to use relative coordinates
in the spherical joint as states, and therefore in this situation
parameter enforceStates might be set to <b>true</b>.
</p>
<p>
If this joint is used in a <b>loop</b> structure, the default
setting results in a <b>cut-joint</b> that
breaks the loop in independent kinematic pieces, hold together
by the constraints of this joint. As a result, a Modelica translator
will first try to select 3 generalized coordinates in the joints of
the remaining parts of the loop and their first derivative as states
and if this is not possible, e.g., because there are only spherical
joints in the loop, will select coordinates from a body of the loop
as states.
</p>
<p>
In the following figure the animation of a spherical
joint is shown. The light blue coordinate system is
frame_a and the dark blue coordinate system is
frame_b of the joint.
(here: angles_start = {45, 45, 45}<sup>o</sup>).
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Joints/Spherical.png\">
</p>
</html>
"),
      Icon(
        Ellipse(extent=[-70, -70; 70, 70], style(
            color=10,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[-49, -50; 51, 50], style(
            color=10,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[30, 70; 71, -68], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-100, 10; -68, -10], style(
            color=10,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[23, 10; 100, -10], style(
            color=10,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-24, 25; 26, -25], style(
            color=0,
            gradient=3,
            fillColor=9)),
        Text(extent=[-100, -132; 100, -72], string="%name")),
      Diagram(
        Ellipse(extent=[-70, -70; 70, 70], style(
            color=10,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[-49, -50; 51, 50], style(
            color=10,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[30, 70; 71, -68], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-100, 10; -68, -10], style(
            color=10,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[23, 10; 100, -10], style(
            color=10,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-24, 25; 26, -25], style(
            color=0,
            gradient=3,
            fillColor=9))));

  protected
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    Visualizers.Advanced.Shape sphere[ndim](
      each shapeType="sphere",
      each color=sphereColor,
      each length=sphereDiameter,
      each width=sphereDiameter,
      each height=sphereDiameter,
      each lengthDirection={1,0,0},
      each widthDirection={0,1,0},
      each r_shape={-0.5,0,0}*sphereDiameter,
      each r=frame_a.r_0,
      each R=frame_a.R);

    // Declarations for quaternions (dummies, if quaternions are not used)
    parameter Frames.Quaternions.Orientation Q_start=MultiBody.Frames.to_Q(
        R_rel_start)
      "Quaternion orientation object from frame_a to frame_b at initial time";
    Frames.Quaternions.Orientation Q(start=Q_start, stateSelect=if
          enforceStates and useQuaternions then StateSelect.prefer else
          StateSelect.never)
      "Quaternion orientation object from frame_a to frame_b (dummy value, if quaternions are not used as states)";

    // Declaration for 3 angles
    parameter SI.Angle phi_start[3]=if sequence_start[1] ==
        sequence_angleStates[1] and sequence_start[2] == sequence_angleStates[2]
         and sequence_start[3] == sequence_angleStates[3] then Cv.from_deg(
        angles_start) else Frames.axesRotationsAngles(R_rel_start,
        sequence_angleStates) "Potential angle states at initial time";
    SI.Angle phi[3](start=phi_start, stateSelect=if enforceStates and not
          useQuaternions then StateSelect.always else StateSelect.never)
      "Dummy or 3 angles to rotate frame_a into frame_b";
    SI.AngularVelocity phi_d[3](stateSelect=if enforceStates and not
          useQuaternions then StateSelect.always else StateSelect.never)
      "= der(phi)";
    SI.AngularAcceleration phi_dd[3] "= der(phi_d)";

    // Other declarations
    SI.AngularVelocity w_rel[3](start=w_rel_start_rad, stateSelect=if
          enforceStates and useQuaternions then StateSelect.always else
          StateSelect.never)
      "Dummy or relative angular velocity of frame_b with respect to frame_a, resolved in frame_b";
    Frames.Orientation R_rel
      "Dummy or relative orientation object to rotate from frame_a to frame_b";
    Frames.Orientation R_rel_inv
      "Dummy or relative orientation object to rotate from frame_b to frame_a";
  initial equation
    if initType == Types.Init.Position or initType == Types.Init.
        PositionVelocity or initType == Types.Init.PositionVelocityAcceleration
         then
      // Initialize positional variables
      if not enforceStates then
        // no states defined in spherical object
        Frames.smallRotation(R_rel_start) =
          Frames.Orientation.equalityConstraint(frame_a.R, frame_b.R);
      elseif useQuaternions then
        // Quaternions Q are used as states
        zeros(3) = Frames.Quaternions.Orientation.equalityConstraint(Q, Q_start);
      else
        // The 3 angles 'phi' are used as states
        phi = phi_start;
      end if;
    end if;

    if initType == Types.Init.PositionVelocity or initType == Types.Init.
        PositionVelocityAcceleration or initType == Types.Init.Velocity or
        initType == Types.Init.VelocityAcceleration then
      // Initialize velocity variables
      w_rel = w_rel_start_rad;
    end if;

    if initType == Types.Init.VelocityAcceleration or initType == Types.Init.
        PositionVelocityAcceleration then
      // Initialize acceleration variables
      der(w_rel) = z_rel_start_rad;
    end if;

    if initType == Types.Init.SteadyState then
      w_rel = zeros(3);
      der(w_rel) = zeros(3);
    end if;
    // torque balance
  equation
    zeros(3) = frame_a.t;
    zeros(3) = frame_b.t;

    if enforceStates then
      defineBranch(frame_a.R, frame_b.R);

      frame_b.r_0 = frame_a.r_0;
      if rooted(frame_a.R) then
        R_rel_inv = Frames.nullRotation();
        frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
        zeros(3) = frame_a.f + Frames.resolve1(R_rel, frame_b.f);
      else
        R_rel_inv = Frames.Orientation(T=transpose(R_rel.T), w=-Frames.resolve1
          (R_rel, R_rel.w));
        frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel_inv);
        zeros(3) = frame_b.f + Frames.resolve2(R_rel, frame_a.f);
      end if;
      // Compute relative orientation object
      if useQuaternions then
        // Use Quaternions as states (with dynamic state selection)
        {0} = Frames.Quaternions.orientationConstraint(Q);
        w_rel = Frames.Quaternions.angularVelocity2(Q, der(Q));
        R_rel = Frames.from_Q(Q, w_rel);

        // Dummies
        phi = zeros(3);
        phi_d = zeros(3);
        phi_dd = zeros(3);

      else
        // Use angles as states
        phi_d = der(phi);
        phi_dd = der(phi_d);
        R_rel = Frames.axesRotations(sequence_angleStates, phi, phi_d);
        w_rel = Frames.angularVelocity2(R_rel);

        // Dummies
        Q = zeros(4);
      end if;

    else
      // Spherical joint does not have states
      // frame_b.r_0 = frame_a.r_0;

        // transpose(frame_b.R.T)*(frame_b.R.T*frame_b.r_0) = transpose(frame_a.R.T)*(frame_a.R.T*frame_a.r_0);
      frame_b.r_0 = transpose(frame_b.R.T)*(frame_b.R.T*(transpose(frame_a.R.T)
        *(frame_a.R.T*frame_a.r_0)));
      zeros(3) = frame_a.f + Frames.resolveRelative(frame_b.f, frame_b.R,
        frame_a.R);

      if initType == Types.Init.Free or initType == Types.Init.Position then
        // dummies
        w_rel = zeros(3);
      else
        w_rel = Frames.angularVelocity2(frame_b.R) - Frames.resolve2(frame_b.R,
           Frames.angularVelocity1(frame_a.R));
      end if;

      // Dummies
      R_rel = Frames.nullRotation();
      R_rel_inv = Frames.nullRotation();
      Q = zeros(4);
      phi = zeros(3);
      phi_d = zeros(3);
      phi_dd = zeros(3);
    end if;
  end Spherical;

  model FreeMotion
    "Free motion joint (6 degrees-of-freedom, 12 potential states)"

    import Modelica.Math.*;
    import SI = Modelica.SIunits;
    import Cv = Modelica.SIunits.Conversions;

    Interfaces.Frame_a frame_a annotation (extent=[-120, -15; -100, 15]);
    Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);

    parameter Boolean animation=true
      "= true, if animation shall be enabled (show arrow from frame_a to frame_b)";

    parameter Types.Init.Temp initType=Types.Init.Free
      "|Initialization| Type of initialization (defines usage of start values below)";

    parameter SI.Position r_rel_a_start[3]={0,0,0}
      "|Initialization| Initial values of r_rel_a (vector from origin of frame_a to origin of frame_b resolved in frame_a)";
    parameter MultiBody.Types.RotationSequence sequence_start={1,2,3}
      "|Initialization| Sequence of rotations to rotate frame_a into frame_b at initial time"
      annotation (Evaluate=true);
    parameter Cv.NonSIunits.Angle_deg angles_start[3]={0,0,0}
      "|Initialization| Initial values of angles to rotate frame_a around 'sequence_start' axes into frame_b"
      annotation (Evaluate=false);
    parameter SI.Velocity v_rel_a_start[3]={0,0,0}
      "|Initialization| Initial values of velocity v_rel_a = der(r_rel_a)";
    parameter MultiBody.Types.AngularVelocity_degs w_rel_a_start[3]={0,0,0}
      "|Initialization| Initial values of angular velocity of frame_b with respect to frame_a resolved in frame_a";
    parameter SI.Acceleration a_rel_a_start[3]={0,0,0}
      "|Initialization| Initial values of acceleration a_rel_a = der(v_rel_a)";
    parameter MultiBody.Types.AngularAcceleration_degs2 z_rel_a_start[3]={0,0,0}

      "|Initialization| Initial values of angular acceleration z_rel_a = der(w_rel_a)";

    parameter SI.Length arrowDiameter=world.defaultArrowDiameter
      "|Animation|if animation = true| Diameter of arrow from frame_a to frame_b";
    parameter MultiBody.Types.Color arrowColor=Types.Defaults.SensorColor
      "|Animation|if animation = true| Color of arrow";
    parameter Boolean enforceStates=true
      " = true, if relative variables between frame_a and frame_b shall be used as states"
      annotation (Dialog(tab="Advanced"));
    parameter Boolean useQuaternions=true
      " = true, if quaternions shall be used as states otherwise use 3 angles as states"
      annotation (Dialog(tab="Advanced"));
    parameter Types.RotationSequence sequence_angleStates={1,2,3}
      " Sequence of rotations to rotate frame_a into frame_b around the 3 angles used as states"
       annotation (Evaluate=true, Dialog(tab="Advanced", enable=not
            useQuaternions));

    final parameter Frames.Orientation R_rel_start=
        MultiBody.Frames.axesRotations(sequence_start, Cv.from_deg(angles_start),
         zeros(3)) "Orientation object from frame_a to frame_b at initial time";

    SI.Position r_rel_a[3](start=r_rel_a_start, stateSelect=if enforceStates
           then StateSelect.always else StateSelect.prefer)
      "Position vector from origin of frame_a to origin of frame_b, resolved in frame_a";
    SI.Velocity v_rel_a[3](stateSelect=if enforceStates then StateSelect.always
           else StateSelect.prefer)
      "= der(r_rel_a), i.e., velocity of origin of frame_b with respect to origin of frame_a, resolved in frame_a";
    SI.Acceleration a_rel_a[3] "= der(v_rel_a)";
    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.16,
        y=0,
        width=0.65,
        height=0.79),
      Documentation(info="<HTML>
<p>
Joint which does not constrain the motion between frame_a and frame_b.
Such a joint is only meaningful if the <b>relative</b> distance and orientation
between frame_a and frame_b, and their derivatives, shall be used
as <b>states</b>.
</p>
<p>
Note, that <b>bodies</b> such as Parts.Body, Parts.BodyShape,
have potential states describing the distance
and orientation, and their derivatives, between the <b>world frame</b> and
a <b>body fixed frame</b>.
Therefore, if these potential state variables are suited,
a FreeMotion joint is not needed.
</p>

The states of the FreeMotion object are:
</p>
<ul>
<li> The <b>relative position vector</b> r_rel_a from the origin of
     frame_a to the origin of frame_b, resolved in
     frame_a and the <b>relative velocity</b> v_rel_a of the origin of
     frame_b with respect to the origin of frame_a, resolved in frame_a
     (= der(r_rel_a)).</li>
</li>
<li> If parameter <b>useQuaternions</b> in the \"Advanced\" menu
     is <b>true</b> (this is the default), then <b>4 quaternions</b>
     are states. Additionally, the coordinates of the
     relative angular velocity vector are 3 potential states.<br>
     If <b>useQuaternions</b> in the \"Advanced\" menu
     is <b>false</b>, then <b>3 angles</b> and the derivatives of
     these angles are potential states. The orientation of frame_b
     is computed by rotating frame_a along the axes defined
     in parameter vector \"sequence_angleStates\" (default = {1,2,3}, i.e.,
     the Cardan angle sequence) around the angles used as states.
     For example, the default is to rotate the x-axis of frame_a
     around angles[1], the new y-axis around angles[2] and the new z-axis
     around angles[3], arriving at frame_b.
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
of the operating region, the 3 angles might be used as
states by setting <b>useQuaternions</b> = <b>false</b>.
</p>
<p>
In text books about 3-dimensional mechanics often 3 angles and the
angular velocity are used as states. This is not the case here, since
3 angles and their derivatives are used as states
(if useQuaternions = false). The reason
is that for real-time simulation the discretization formula of the
integrator might be \"inlined\" and solved together with the model equations.
By appropriate symbolic transformation the performance is
drastically increased if angles and their
derivatives are used as states, instead of angles and the angular
velocity.
</p>
<p>
If parameter
<b>enforceStates</b> is set to <b>true</b> (= the default)
in the \"Advanced\" menu,
then FreeMotion variables are forced to be used as states according
to the setting of parameters \"useQuaternions\" and
\"sequence_angleStates\".
</p>

<p>
In the following figure the animation of a FreeMotion
joint is shown. The light blue coordinate system is
frame_a and the dark blue coordinate system is
frame_b of the joint.
(here: r_rel_a_start = {0.5, 0, 0.5}, angles_start = {45, 45, 45}<sup>o</sup>).
</p>

<p align=\"center\">
<IMG SRC=\"../Images/Joints/FreeMotion.png\">
</p>


</HTML>
"),
      Icon(
        Line(points=[-86, 31; -74, 61; -49, 83; -17, 92; 19, 88; 40, 69; 59, 48],
             style(
            color=9,
            thickness=2,
            fillColor=8)),
        Polygon(points=[90, 0; 50, 20; 50, -20; 90, 0], style(color=0,
              fillColor=8)),
        Polygon(points=[69, 58; 49, 40; 77, 28; 69, 58], style(color=0,
              fillColor=8)),
        Text(
          extent=[136, -35; -150, -98],
          string="%name",
          style(color=3)),
        Rectangle(extent=[-70, -5; -90, 5], style(color=0, fillColor=8)),
        Rectangle(extent=[50, -5; 30, 5], style(color=0, fillColor=8)),
        Rectangle(extent=[11, -5; -9, 5], style(color=0, fillColor=8)),
        Rectangle(extent=[-30, -5; -50, 5], style(color=0, fillColor=8))),
      Diagram(
        Line(points=[-86, 31; -74, 61; -49, 83; -17, 92; 19, 88; 40, 69; 59, 48],
             style(
            color=9,
            thickness=2,
            fillColor=8)),
        Polygon(points=[90, 0; 50, 20; 50, -20; 90, 0], style(color=0,
              fillColor=8)),
        Polygon(points=[69, 58; 49, 40; 77, 28; 69, 58], style(color=0,
              fillColor=8)),
        Rectangle(extent=[50, -5; 30, 5], style(color=0, fillColor=8)),
        Rectangle(extent=[11, -5; -9, 5], style(color=0, fillColor=8)),
        Rectangle(extent=[-30, -5; -50, 5], style(color=0, fillColor=8)),
        Rectangle(extent=[-70, -5; -90, 5], style(color=0, fillColor=8))));

  protected
    outer MultiBody.World world;

    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    Visualizers.Advanced.Arrow arrow[ndim](
      each r_head=r_rel_a,
      each diameter=arrowDiameter,
      each color=arrowColor,
      each r=frame_a.r_0,
      each R=frame_a.R);

    // Initial values
    parameter SI.AngularVelocity w_rel_b_start_rad[3]=MultiBody.Frames.resolve2
        (R_rel_start, w_rel_a_start*Modelica.Constants.D2R);
    parameter SI.AngularAcceleration z_rel_b_start_rad[3]=
        MultiBody.Frames.resolve2(R_rel_start, z_rel_a_start*Modelica.Constants
        .D2R);

    // Declarations for quaternions (dummies, if quaternions are not used)
    parameter Frames.Quaternions.Orientation Q_start=MultiBody.Frames.to_Q(
        R_rel_start)
      "Quaternion orientation object from frame_a to frame_b at initial time";
    Frames.Quaternions.Orientation Q(start=Q_start, stateSelect=if
          enforceStates then (if useQuaternions then StateSelect.prefer else
          StateSelect.never) else StateSelect.default)
      "Quaternion orientation object from frame_a to frame_b (dummy value, if quaternions are not used as states)";

    // Declaration for 3 angles
    parameter SI.Angle phi_start[3]=if sequence_start[1] ==
        sequence_angleStates[1] and sequence_start[2] == sequence_angleStates[2]
         and sequence_start[3] == sequence_angleStates[3] then Cv.from_deg(
        angles_start) else Frames.axesRotationsAngles(R_rel_start,
        sequence_angleStates) "Potential angle states at initial time";
    SI.Angle phi[3](start=phi_start, stateSelect=if enforceStates then (if
          useQuaternions then StateSelect.never else StateSelect.always) else
          StateSelect.default)
      "Dummy or 3 angles to rotate frame_a into frame_b";
    SI.AngularVelocity phi_d[3](stateSelect=if enforceStates then (if
          useQuaternions then StateSelect.never else StateSelect.always) else
          StateSelect.default) "= der(phi)";
    SI.AngularAcceleration phi_dd[3] "= der(phi_d)";

    // Other declarations
    SI.AngularVelocity w_rel_b[3](start=w_rel_b_start_rad, stateSelect=if
          enforceStates then (if useQuaternions then StateSelect.always else
          StateSelect.avoid) else StateSelect.default)
      "Dummy or relative angular velocity of frame_b with respect to frame_a, resolved in frame_b";
    Frames.Orientation R_rel
      "Dummy or relative orientation object to rotate from frame_a to frame_b";
    Frames.Orientation R_rel_inv
      "Dummy or relative orientation object to rotate from frame_b to frame_a";

  initial equation
    if initType == Types.Init.Position or initType == Types.Init.
        PositionVelocity or initType == Types.Init.PositionVelocityAcceleration
         then
      // Initialize positional variables
      r_rel_a = r_rel_a_start;
      if not enforceStates then
        // no states defined
        Frames.smallRotation(R_rel_start) =
          Frames.Orientation.equalityConstraint(frame_a.R, frame_b.R);
      elseif useQuaternions then
        // Quaternions Q are used as states
        zeros(3) = Frames.Quaternions.Orientation.equalityConstraint(Q, Q_start);
      else
        // The 3 angles 'phi' are used as states
        phi = phi_start;
      end if;
    end if;

    if initType == Types.Init.PositionVelocity or initType == Types.Init.
        PositionVelocityAcceleration or initType == Types.Init.Velocity or
        initType == Types.Init.VelocityAcceleration then
      // Initialize velocity variables
      v_rel_a = v_rel_a_start;
      w_rel_b = w_rel_b_start_rad;
    end if;

    if initType == Types.Init.VelocityAcceleration or initType == Types.Init.
        PositionVelocityAcceleration then
      // Initialize acceleration variables
      a_rel_a = a_rel_a_start;
      der(w_rel_b) = z_rel_b_start_rad;
    end if;

    if initType == Types.Init.SteadyState then
      v_rel_a = zeros(3);
      w_rel_b = zeros(3);
      a_rel_a = zeros(3);
      der(w_rel_b) = zeros(3);
    end if;

  equation
    assert(cardinality(frame_a) > 0,
      "Connector frame_a of FreeMotion joint is not connected");
    assert(cardinality(frame_b) > 0,
      "Connector frame_b of FreeMotion joint is not connected");

    // Kinematic differential equations for translational motion
    der(r_rel_a) = v_rel_a;
    der(v_rel_a) = a_rel_a;

    // Kinematic relationships
    frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, r_rel_a);

    // Cut-forces and cut-torques are zero
    frame_a.f = zeros(3);
    frame_a.t = zeros(3);
    frame_b.f = zeros(3);
    frame_b.t = zeros(3);

    if enforceStates then
      defineBranch(frame_a.R, frame_b.R);

      if rooted(frame_a.R) then
        R_rel_inv = Frames.nullRotation();
        frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
      else
        R_rel_inv = Frames.Orientation(T=transpose(R_rel.T), w=-Frames.resolve1
          (R_rel, R_rel.w));
        frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel_inv);
      end if;

      // Compute relative orientation object
      if useQuaternions then
        // Use Quaternions as states (with dynamic state selection)
        {0} = Frames.Quaternions.orientationConstraint(Q);
        w_rel_b = Frames.Quaternions.angularVelocity2(Q, der(Q));
        R_rel = Frames.from_Q(Q, w_rel_b);

        // Dummies
        phi = zeros(3);
        phi_d = zeros(3);
        phi_dd = zeros(3);

      else
        // Use angles as states
        phi_d = der(phi);
        phi_dd = der(phi_d);
        R_rel = Frames.axesRotations(sequence_angleStates, phi, phi_d);
        w_rel_b = Frames.angularVelocity2(R_rel);

        // Dummies
        Q = zeros(4);
      end if;

    else
      // Free motion joint does not have states
      if initType == Types.Init.Free or initType == Types.Init.Position then
        // dummies
        w_rel_b = zeros(3);
      else
        w_rel_b = Frames.angularVelocity2(frame_b.R) - Frames.resolve2(frame_b.
          R, Frames.angularVelocity1(frame_a.R));
      end if;

      // Dummies
      R_rel = Frames.nullRotation();
      R_rel_inv = Frames.nullRotation();
      Q = zeros(4);
      phi = zeros(3);
      phi_d = zeros(3);
      phi_dd = zeros(3);
    end if;
  end FreeMotion;

  model SphericalSpherical
    "Spherical - spherical joint aggregation (1 constraint, no potential states) with an optional point mass in the middle"


    import SI = Modelica.SIunits;
    extends Interfaces.PartialTwoFrames;

    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Boolean showMass=true
      "= true, if mass shall be shown (provided animation = true and m > 0)";
    parameter Boolean computeRodLength=false
      "= true, if rodLength shall be computed during initialization (see info)";
    parameter SI.Length rodLength(
      min=Modelica.Constants.eps,
      fixed=not computeRodLength) = 1
      "Distance between the origins of frame_a and frame_b (if computeRodLength=true, guess value)";
    parameter SI.Mass m=0 "Mass of rod (= point mass located in middle of rod)";
    parameter Real sphereDiameter=world.defaultJointLength
      "|Animation|if animation = true| Diameter of spheres respresenting the spherical joints";
    parameter MultiBody.Types.Color sphereColor=MultiBody.Types.Defaults.
        JointColor
      "|Animation|if animation = true| Color of spheres respresenting the spherical joints";
    parameter Real rodDiameter=sphereDiameter/MultiBody.Types.Defaults.
        JointRodDiameterFraction
      "|Animation|if animation = true| Diameter of rod connecting the two spherical joint";
    parameter MultiBody.Types.Color rodColor=MultiBody.Types.Defaults.RodColor
      "|Animation|if animation = true| Color of rod connecting the two spherical joints";
    parameter Real massDiameter=sphereDiameter
      "|Animation|if animation = true and showMass = true and m > 0| Diameter of sphere representing the mass point";
    parameter MultiBody.Types.Color massColor=MultiBody.Types.Defaults.
        BodyColor
      "|Animation|if animation = true and showMass = true and m > 0| Color of sphere representing the mass point";

    parameter Boolean kinematicConstraint=true
      "|Advanced|| = false, if no constraint shall be defined, due to analytically solving a kinematic loop";
    parameter Boolean checkTotalPower=false
      "|Advanced|| = true, if total power flowing into this component shall be determined (must be zero)";

    SI.Force f_rod
      "Constraint force in direction of the rod (positive on frame_a, when directed from frame_a to frame_b)";
    SI.Position rRod_0[3]
      "Position vector from frame_a to frame_b resolved in world frame";
    SI.Position rRod_a[3]
      "Position vector from frame_a to frame_b resolved in frame_a";
    SI.Position eRod_a[3]
      "Unit vector in direction from frame_a to frame_b, resolved in frame_a";
    SI.Position r_CM_0[3]
      "Dummy if m==0, or position vector from world frame to mid-point of rod, resolved in world frame";
    SI.Velocity v_CM_0[3] "First derivative of r_CM_0";
    SI.Force f_CM_a[3]
      "Dummy if m==0, or inertial force acting at mid-point of rod due to mass oint acceleration, resolved in frame_a";
    SI.Force f_CM_e[3]
      "Dummy if m==0, or projection of f_CM_a onto eRod_a, resolved in frame_a";
    SI.Force f_b_a1[3]
      "Force acting at frame_b, but without force in rod, resolved in frame_a";
    SI.Power totalPower
      "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";

    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.24,
        y=0.02,
        width=0.69,
        height=0.78),
      Icon(
        Ellipse(extent=[-100, -40; -20, 40], style(
            color=10,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[-90, -30; -30, 30], style(
            color=0,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[20, -40; 100, 40], style(
            color=10,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[31, -29; 91, 30], style(
            color=10,
            fillColor=7,
            fillPattern=1)),
        Text(extent=[-149, 111; 141, 51], string="%name"),
        Rectangle(extent=[-40, 40; 41, -41], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-51, 6; 48, -4], style(
            color=1,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-74, 15; -45, -13], style(
            color=0,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[45, 14; 74, -14], style(
            color=0,
            gradient=3,
            fillColor=8)),
        Text(
          extent=[-130, -58; 137, -98],
          style(color=0),
          string="%rodLength")),
      Diagram(
        Ellipse(extent=[-100, -40; -20, 40], style(
            color=9,
            gradient=0,
            fillColor=9,
            fillPattern=1)),
        Ellipse(extent=[-90, -30; -30, 30], style(
            color=9,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[20, -40; 100, 40], style(
            color=9,
            fillColor=9,
            fillPattern=1)),
        Ellipse(extent=[30, -29; 90, 30], style(
            color=8,
            fillColor=7,
            fillPattern=1)),
        Line(points=[-60, -60; 46, -60]),
        Polygon(points=[60, -60; 45, -54; 45, -66; 60, -60], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Text(extent=[-37, -63; 33, -79], string="rodLength"),
        Rectangle(extent=[-40, 41; 40, -40], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-51, 6; 48, -4], style(
            color=1,
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Ellipse(extent=[-74, 15; -45, -13], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Ellipse(extent=[44, 14; 73, -14], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Line(points=[-60, -71; -60, 1]),
        Line(points=[60, -72; 60, 0]),
        Polygon(points=[11, 1; -1, 4; -1, -2; 11, 1], style(fillPattern=7)),
        Line(points=[-60, 1; -1, 1], style(fillColor=0, fillPattern=1)),
        Text(
          extent=[-32, -4; 4, -29],
          style(gradient=0, fillPattern=0),
          string="eRod_a")),
      Documentation(info="<html>
<p>
Joint that has a spherical joint on each of its two ends.
The rod connecting the two spherical joints is approximated by a
point mass that is located in the middle of the rod. When the mass
is set to zero (default), special code for a massless body is generated.
In the following default animation figure, the two spherical joints are
represented by two red spheres, the connecting rod by a grey cylinder
and the point mass in the middle of the rod by a light blue sphere:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Joints/SphericalSpherical.png\" ALT=\"model Joints.SphericalSpherical\">
</p>
This joint introduces <b>one constraint</b> defining that the distance between
the origin of frame_a and the origin of frame_b is constant (= rodLength).
It is highly recommended to use this joint in loops
whenever possible, because this enhances the efficiency
considerably due to smaller systems of non-linear algebraic
equations.
</p>
<p>
It is sometimes desirable to <b>compute</b> the <b>rodLength</b>
of the connecting rod during initialization. For this, parameter
<b>computeLength</b> has to be set to <b>true</b> and instead <b>one</b> other,
easier to determine, position variable in the same loop
needs to have a fixed attribute of <b>true</b>. For example,
if a loop consists of one Revolute joint, one Prismatic joint and
a SphericalSpherical joint, one may fix the start values of the revolute
joint angle and of the relative distance of the prismatic joint
in order to compute the rodLength of the rod.
</p>
<p>
It is not possible to connect other components, such as a body with mass
properties or a special visual shape object to the rod connecting
the two spherical joints. If this is needed, use instead joint Joints.<b>UniversalSpherical</b>
that has this property.
</p>
</html>"));
  protected
    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    parameter Integer ndim2=if world.enableAnimation and animation and showMass
         and m > 0 then 1 else 0;
    Visualizers.Advanced.Shape shape_rod[ndim](
      each shapeType="cylinder",
      each color=rodColor,
      each length=rodLength,
      each width=rodDiameter,
      each height=rodDiameter,
      each lengthDirection=eRod_a,
      each widthDirection={0,1,0},
      each r=frame_a.r_0,
      each R=frame_a.R);
    Visualizers.Advanced.Shape shape_a[ndim](
      each shapeType="sphere",
      each color=sphereColor,
      each length=sphereDiameter,
      each width=sphereDiameter,
      each height=sphereDiameter,
      each lengthDirection=eRod_a,
      each widthDirection={0,1,0},
      each r_shape=-eRod_a*(sphereDiameter/2),
      each r=frame_a.r_0,
      each R=frame_a.R);
    Visualizers.Advanced.Shape shape_b[ndim](
      each shapeType="sphere",
      each color=sphereColor,
      each length=sphereDiameter,
      each width=sphereDiameter,
      each height=sphereDiameter,
      each lengthDirection=eRod_a,
      each widthDirection={0,1,0},
      each r_shape=eRod_a*(rodLength - sphereDiameter/2),
      each r=frame_a.r_0,
      each R=frame_a.R);
    Visualizers.Advanced.Shape shape_mass[ndim2](
      each shapeType="sphere",
      each color=massColor,
      each length=massDiameter,
      each width=massDiameter,
      each height=massDiameter,
      each lengthDirection=eRod_a,
      each widthDirection={0,1,0},
      each r_shape=eRod_a*(rodLength/2 - sphereDiameter/2),
      each r=frame_a.r_0,
      each R=frame_a.R);
  equation
    // Determine relative position vector between the two frames
    if kinematicConstraint then
      rRod_0 = transpose(frame_b.R.T)*(frame_b.R.T*frame_b.r_0) - transpose(
        frame_a.R.T)*(frame_a.R.T*frame_a.r_0);
    else
      rRod_0 = frame_b.r_0 - frame_a.r_0;
    end if;

    rRod_a = Frames.resolve2(frame_a.R, rRod_0);
    eRod_a = rRod_a/rodLength;

    /* Constraint equation is removed, when taken into account somewhere else,
     e.g., when analytically solving a kinematic loop
  */
    if kinematicConstraint then
      0 = rRod_0*rRod_0 - rodLength*rodLength;
    end if;

    // Cut-torques at frame_a and frame_b
    frame_a.t = zeros(3);
    frame_b.t = zeros(3);

    /* Force and torque balance of rod
     - Kinematics for center of mass CM of mass point
       r_CM_0 = frame_a.r_0 + rRod_0/2;
       v_CM_0 = der(r_CM_0);
       a_CM_a = resolve2(frame_a.R, der(v_CM_0) - world.gravityAcceleration(r_CM_0));
     - Inertial and gravity force in direction (f_CM_e) and orthogonal (f_CM_n) to rod
       f_CM_a = m*a_CM_a
       f_CM_e = f_CM_a*eRod_a;           // in direction of rod
       f_CM_n = rodLength(f_CM_a - f_CM_e);  // orthogonal to rod
     - Force balance in direction of rod
       f_CM_e = fa_rod_e + fb_rod_e;
     - Force balance orthogonal to rod
       f_CM_n = fa_rod_n + fb_rod_n;
     - Torque balance with respect to frame_a
       0 = (-f_CM_n)*rodLength/2 + fb_rod_n*rodLength
     The result is:
     fb_rod_n = f_CM_n/2;
     fa_rod_n = fb_rod_n;
     fb_rod_e = f_CM_e - fa_rod_e;
     fa_rod_e is the unknown computed from loop
  */


      // f_b_a1 is needed in aggregation joints to solve kinematic loops analytically
    if m > 0 then
      r_CM_0 = frame_a.r_0 + rRod_0/2;
      v_CM_0 = der(r_CM_0);
      f_CM_a = m*Frames.resolve2(frame_a.R, der(v_CM_0) -
        world.gravityAcceleration(r_CM_0));
      f_CM_e = (f_CM_a*eRod_a)*eRod_a;
      frame_a.f = (f_CM_a - f_CM_e)/2 + f_rod*eRod_a;
      f_b_a1 = (f_CM_a + f_CM_e)/2;
      frame_b.f = Frames.resolveRelative(f_b_a1 - f_rod*eRod_a, frame_a.R,
        frame_b.R);
    else
      r_CM_0 = zeros(3);
      v_CM_0 = zeros(3);
      f_CM_a = zeros(3);
      f_CM_e = zeros(3);
      f_b_a1 = zeros(3);
      frame_a.f = f_rod*eRod_a;
      frame_b.f = -Frames.resolveRelative(frame_a.f, frame_a.R, frame_b.R);
    end if;

    if checkTotalPower then
      totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) +
        frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + (-m)*(der(
        v_CM_0) - world.gravityAcceleration(r_CM_0))*v_CM_0 + frame_a.t*
        Frames.angularVelocity2(frame_a.R) + frame_b.t*Frames.angularVelocity2(
        frame_b.R);
    else
      totalPower = 0;
    end if;
  end SphericalSpherical;

  model UniversalSpherical
    "Universal - spherical joint aggregation (1 constraint, no potential states)"


    import SI = Modelica.SIunits;
    extends Interfaces.PartialTwoFrames;
    Interfaces.Frame_a frame_ia
      annotation (extent=[-55, 100; -25, 121], rotation=-90);

    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter Boolean showUniversalAxes=true
      " = true, if universal joint shall be visualized with two cylinders, otherwise with a sphere (provided animation=true)";
    parameter Boolean computeRodLength=false
      "= true, if distance between frame_a and frame_b shall be computed during initialization (see info)";
    parameter MultiBody.Types.Axis n1_a={0,0,1}
      "Axis 1 of universal joint resolved in frame_a (axis 2 is orthogonal to axis 1 and to rod)"
      annotation (Evaluate=true);
    parameter SI.Position rRod_ia[3]={1,0,0}
      "Vector from origin of frame_a to origin of frame_b, resolved in frame_ia (if computeRodLength=true, rRod_ia is only an axis vector along the connecting rod)"
      annotation (Evaluate=true);
    parameter SI.Diameter sphereDiameter=world.defaultJointLength
      "|Animation|if animation = true| Diameter of spheres representing the universal and the spherical joint";
    parameter MultiBody.Types.Color sphereColor=MultiBody.Types.Defaults.
        JointColor
      "|Animation|if animation = true| Color of spheres representing the universal and the spherical joint";
    parameter MultiBody.Types.ShapeType rodShapeType="cylinder"
      "|Animation|if animation = true| Shape type of rod connecting the universal and the spherical joint";
    parameter SI.Distance rodWidth=sphereDiameter/MultiBody.Types.Defaults.
        JointRodDiameterFraction
      "|Animation|if animation = true| Width of rod shape in direction of axis 2 of universal joint.";
    parameter SI.Distance rodHeight=rodWidth
      "|Animation|if animation = true| Height of rod shape in direction that is orthogonal to rod and to axis 2.";
    parameter Real rodExtra=0.0
      "|Animation|if animation = true| Additional parameter depending on rodShapeType (see docu of Visualizers.FixedShape).";
    parameter MultiBody.Types.Color rodColor=MultiBody.Types.Defaults.RodColor
      "|Animation|if animation = true| Color of rod shape connecting the universal and the spherical joints";
    parameter SI.Distance cylinderLength=world.defaultJointLength
      "|Animation|if animation = true and showUniversalAxes| Length of cylinders representing the two universal joint axes";
    parameter SI.Distance cylinderDiameter=world.defaultJointWidth
      "|Animation|if animation = true and showUniversalAxes| Diameter of cylinders representing the two universal joint axes";
    parameter MultiBody.Types.Color cylinderColor=Types.Defaults.JointColor
      "|Animation|if animation = true and showUniversalAxes| Color of cylinders representing the two universal joint axes";
    parameter Boolean kinematicConstraint=true
      "|Advanced|| = false, if no constraint shall be defined, due to analytically solving a kinematic loop";
    parameter Boolean checkTotalPower=false
      "|Advanced|| = true, if total power flowing into this component shall be determined (must be zero)";
    SI.Force f_rod
      "Constraint force in direction of the rod (positive, if rod is pressed)";
    final parameter SI.Distance rodLength(fixed=not computeRodLength) =
      Frames.length(rRod_ia)
      "Length of rod (distance between origin of frame_a and origin of frame_b)";
    final parameter Real eRod_ia[3]=Frames.normalize(rRod_ia)
      "Unit vector from origin of frame_a to origin of frame_b, resolved in frame_ia";
    final parameter Real e2_ia[3]=Frames.normalize(cross(n1_a, eRod_ia))
      "Unit vector in direction of axis 2 of universal joint, resolved in frame_ia (orthogonal to n1_a and eRod_ia; note: frame_ia is parallel to frame_a when the universal joint angles are zero)";
    final parameter Real e3_ia[3]=cross(eRod_ia, e2_ia)
      "Unit vector perpendicular to eRod_ia and e2_ia, resolved in frame_ia";
    SI.Power totalPower
      "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";
    SI.Force f_b_a1[3]
      "frame_b.f without f_rod part, resolved in frame_a (needed for analytic loop handling)";
    Real eRod_a[3]
      "Unit vector in direction of rRod_a, resolved in frame_a (needed for analytic loop handling)";
    SI.Position rRod_0[3](start=rRod_ia)
      "Position vector from origin of frame_a to origin of frame_b resolved in world frame";
    SI.Position rRod_a[3](start=rRod_ia)
      "Position vector from origin of frame_a to origin of frame_b resolved in frame_a";
    annotation (
      preferedView="info",
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.19,
        y=0.01,
        width=0.81,
        height=0.81),
      Documentation(info="<html>
<p>
This component consists of a <b>universal joint</b> at frame_a and
a <b>spherical joint</b> at frame_b that are connected together with
a <b>rigid rod</b>, see default aimation figure (the arrows are not
part of the default animation):
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Joints/UniversalSpherical.png\" ALT=\"model Joints.UniversalSpherical\">
</p>
<p>
This joint aggregation has no mass and no inertia and introduces the constraint
that the distance between the origin of frame_a and the origin of frame_b is constant
(= Frames.length(rRod_ia)). The universal joint is defined in the following way:
<p>
<ul>
<li> The rotation <b>axis</b> of revolute joint <b>1</b> is along parameter
     vector n1_a which is fixed in frame_a.<li>
<li> The rotation <b>axis</b> of revolute joint <b>2</b> is perpendicular to
     axis 1 and to the line connecting the universal and the spherical joint.
</ul>
<p>
The definition of axis 2 of the universal joint is performed according
to the most often occuring case. In a future release, axis 2 might
be explicitly definable via a parameter. However, the treatment is much more
complicated and the number of operations is considerably higher,
if axis 2 is not orthogonal to axis 1 and to the connecting rod.
</p>
<p>
Note, there is a <b>singularity</b> when axis 1 and the connecting rod are parallel
to each other. Therefore, if possible n1_a should be selected in such a way that it
is perpendicular to rRod_ia in the initial configuration (i.e., the
distance to the singularity is as large as possible).
</p>
<p>
An additional <b>frame_ia</b> is present. It is <b>fixed</b> in the connecting
<b>rod</b> at the origin of <b>frame_a</b>. The placement of frame_ia on the rod
is implicitly defined by the universal joint (frame_a and frame_ia coincide
when the angles of the two revolute joints of the universal joint are zero)
and by parameter vector <b>rRod_ia</b>, the position vector
from the origin of frame_a to the origin of frame_b, resolved in frame_<b>ia</b>.
</p>
<p>
The easiest way to define the parameters of this joint is by moving the
MultiBody system in a <b>reference configuration</b> where <b>all frames</b>
of all components are <b>parallel</b> to each other (alternatively,
at least frame_a and frame_ia of the UniversalSpherical joint
should be parallel to each other when defining an instance of this
component). Since frame_a and frame_ia are parallel to each other,
vector <b>rRod_ia</b> from frame_a to frame_b resolved in frame_<b>ia</b> can be resolved
in frame_<b>a</b> (or the <b>world frame</b>, if all frames are parallel to each other).
</p>
<p>
This joint aggregation can be used in cases where
in reality a rod with spherical joints at each end are present.
Such a system has an additional degree of freedom to rotate
the rod along its axis. In practice this rotation is usually
of no interested and is mathematically removed by replacing one
of the spherical joints by a universal joint. Still, in most
cases the Joints.SphericalSpherical joint aggregation can be used instead
of the UniversalSpherical joint
since the rod is animated and its mass properties are approximated by
a point mass in the middle of the rod. The SphericalSpherical joint
has the advantage that it does not have a singular configuration.
</p>
<p>
In the public interface of the UniversalSpherical joint, the following
(final) <b>parameters</b> are provided:
</p>
<pre>
  <b>parameter</b> Real rodLength(unit=\"m\")  \"Length of rod\";
  <b>parameter</b> Real eRod_ia[3] \"Unit vector along rod, resolved in frame_ia\";
  <b>parameter</b> Real e2_ia  [3] \"Unit vector along axis 2, resolved in frame_ia\";
</pre>
<p>
This allows a more convenient definition of data which is related to the rod.
For example, if a box shall be connected at frame_ia directing from
the origin of frame_a to the middle of the rod, this might be defined as:
</p>
<pre>
    MultiBody.Joints.UniversalSpherical jointUS(rRod_ia={1.2, 1, 0.2});
    MultiBody.Visualizers.FixedShape    shape(shapeType       = \"box\",
                                              lengthDirection = jointUS.eRod_ia,
                                              widthDirection  = jointUS.e2_ia,
                                              length          = jointUS.rodLength/2,
                                              width           = jointUS.rodLength/10);
  <b>equation</b>
    <b>connect</b>(jointUS.frame_ia, shape.frame_a);
</pre>
</html>
"),
      Icon(
        Text(
          extent=[-122, -49; 138, -107],
          style(color=3),
          string="%name"),
        Ellipse(extent=[-100, -40; -19, 40], style(
            color=9,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[-90, -30; -29, 29], style(
            color=9,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-60, 41; -9, -44], style(color=7, fillColor=7)),
        Line(points=[-60, 40; -60, -40], style(
            color=0,
            thickness=2,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[-83, -17; -34, 21], style(
            color=9,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[-74, -12; -40, 15], style(
            color=9,
            fillColor=7,
            fillPattern=1)),
        Polygon(points=[-72, -20; -89, 3; -69, 25; -45, 27; -72, -20], style(
            pattern=0,
            fillColor=7,
            fillPattern=1)),
        Line(points=[-60, 40; -60, -10], style(
            color=0,
            thickness=2,
            fillColor=7,
            fillPattern=1)),
        Line(points=[-49, 20; -69, -15], style(
            color=0,
            thickness=2,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[44, 14; 73, -14], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Ellipse(extent=[20, -40; 100, 40], style(
            color=8,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[30, -30; 90, 30], style(
            color=8,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-22, 45; 40, -43], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[46, 14; 75, -14], style(
            color=0,
            gradient=3,
            fillColor=8)),
        Rectangle(extent=[-36, -8; 48, 8], style(
            pattern=0,
            gradient=2,
            fillColor=8)),
        Text(
          extent=[-102, 126; -64, 94],
          style(color=10),
          string="ia"),
        Text(
          extent=[-24, 103; 167, 64],
          style(color=0),
          string="%rRod_ia"),
        Line(points=[-40, 101; -40, 60; -60, 1], style(color=10, thickness=2))),

      Diagram(
        Line(points=[-60, -70; 46, -70]),
        Polygon(points=[60, -70; 45, -64; 45, -76; 60, -70], style(
            color=3,
            fillColor=3,
            fillPattern=1)),
        Text(extent=[-56, -71; 56, -90], string="rRod"),
        Ellipse(extent=[-100, -40; -19, 40], style(
            color=9,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[-90, -30; -29, 29], style(
            color=9,
            fillColor=7,
            fillPattern=1)),
        Rectangle(extent=[-60, 41; -19, -41], style(color=7, fillColor=7)),
        Line(points=[-60, 40; -60, -40], style(
            color=0,
            thickness=2,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[-83, -17; -34, 21], style(
            color=9,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[-74, -12; -40, 15], style(
            color=9,
            fillColor=7,
            fillPattern=1)),
        Polygon(points=[-72, -20; -89, 3; -69, 25; -45, 27; -72, -20], style(
            pattern=0,
            fillColor=7,
            fillPattern=1)),
        Line(points=[-60, 40; -60, -10], style(
            color=0,
            thickness=2,
            fillColor=7,
            fillPattern=1)),
        Line(points=[-49, 20; -69, -15], style(
            color=0,
            thickness=2,
            fillColor=7,
            fillPattern=1)),
        Polygon(points=[7, -1; -5, 2; -5, -4; 7, -1], style(fillPattern=7)),
        Line(points=[-50, 19; -30, 57], style(fillColor=0, fillPattern=1)),
        Text(
          extent=[-34, 78; 8, 62],
          style(gradient=0, fillPattern=0),
          string="e2"),
        Polygon(points=[-25, 64; -33, 56; -27, 53; -25, 64], style(fillPattern=
                7)),
        Line(points=[-60, 41; -60, 65], style(fillColor=0, fillPattern=1)),
        Polygon(points=[-60, 75; -64, 63; -56, 63; -60, 75], style(fillPattern=
                7)),
        Text(
          extent=[-93, 82; -64, 62],
          style(gradient=0, fillPattern=0),
          string="n1"),
        Line(points=[-60, -40; -60, -72]),
        Ellipse(extent=[20, -40; 100, 40], style(
            color=8,
            gradient=3,
            fillColor=8)),
        Ellipse(extent=[30, -30; 90, 30], style(color=8, fillColor=7)),
        Rectangle(extent=[-22, 45; 40, -43], style(
            color=7,
            fillColor=7,
            fillPattern=1)),
        Ellipse(extent=[45, 14; 74, -14], style(
            color=0,
            fillColor=0,
            fillPattern=1)),
        Rectangle(extent=[-36, -8; 48, 8], style(
            pattern=0,
            gradient=2,
            fillColor=8)),
        Text(
          extent=[-31, -7; 0, -28],
          style(gradient=0, fillPattern=0),
          string="eRod"),
        Line(points=[-60, 0; -5, 0], style(fillColor=0, fillPattern=1)),
        Polygon(points=[7, 0; -5, 3; -5, -3; 7, 0], style(fillPattern=7)),
        Line(points=[60, -1; 60, -72]),
        Line(points=[-40, 100; -40, 70; -60, 0], style(color=10, thickness=2)),

        Text(extent=[-23, 30; 26, 10], string=" eRod*e2 = 0;  n1*e2 = 0")));

  protected
    SI.Force f_b_a[3] "frame_b.f resolved in frame_a";
    SI.Force f_ia_a[3] "frame_ia.f resolved in frame_a";
    SI.Torque t_ia_a[3] "frame_ia.t resolved in frame_a";
    Real n2_a[3]
      "Vector in direction of axis 2 of the universal joint (e2_ia), resolved in frame_a";
    Real length2_n2_a(start=1, unit="m2") "Square of length of vector n2_a";
    SI.Length length_n2_a "Length of vector n2_a";
    Real e2_a[3]
      "Unit vector in direction of axis 2 of the universal joint (e2_ia), resolved in frame_a";
    Real e3_a[3]
      "Unit vector perpendicular to eRod_ia and e2_a, resolved in frame_a";
    Real der_rRod_a_L[3] "= der(rRod_a)/rodLength";
    SI.AngularVelocity w_rel_ia1[3];
    Frames.Orientation R_rel_ia1;
    Frames.Orientation R_rel_ia2;
    // Real T_rel_ia[3, 3];
    Frames.Orientation R_rel_ia "Rotation from frame_a to frame_ia";

    parameter Integer ndim=if world.enableAnimation and animation then 1 else 0;
    parameter Integer ndim1=if world.enableAnimation and animation and not
        showUniversalAxes then 1 else 0;
    parameter Integer ndim2=if world.enableAnimation and animation and
        showUniversalAxes then 1 else 0;
    Visualizers.Advanced.Shape rodShape[ndim](
      each shapeType=rodShapeType,
      each color=rodColor,
      each length=rodLength,
      each width=rodWidth,
      each height=rodHeight,
      each lengthDirection=eRod_ia,
      each widthDirection=e2_ia,
      each r=frame_ia.r_0,
      each R=frame_ia.R);
    Visualizers.Advanced.Shape sphericalShape_b[ndim](
      each shapeType="sphere",
      each color=sphereColor,
      each length=sphereDiameter,
      each width=sphereDiameter,
      each height=sphereDiameter,
      each lengthDirection={1,0,0},
      each widthDirection={0,1,0},
      each r_shape={-0.5,0,0}*sphereDiameter,
      each r=frame_b.r_0,
      each R=frame_b.R);
    Visualizers.Advanced.Shape sphericalShape_a[ndim1](
      each shapeType="sphere",
      each color=sphereColor,
      each length=sphereDiameter,
      each width=sphereDiameter,
      each height=sphereDiameter,
      each lengthDirection={1,0,0},
      each widthDirection={0,1,0},
      each r_shape={-0.5,0,0}*sphereDiameter,
      each r=frame_a.r_0,
      each R=frame_a.R);
    Visualizers.Advanced.Shape universalShape1[ndim2](
      each shapeType="cylinder",
      each color=cylinderColor,
      each length=cylinderLength,
      each width=cylinderDiameter,
      each height=cylinderDiameter,
      each lengthDirection=n1_a,
      each widthDirection={0,1,0},
      each r_shape=-n1_a*(cylinderLength/2),
      each r=frame_a.r_0,
      each R=frame_a.R);
    Visualizers.Advanced.Shape universalShape2[ndim2](
      each shapeType="cylinder",
      each color=cylinderColor,
      each length=cylinderLength,
      each width=cylinderDiameter,
      each height=cylinderDiameter,
      each lengthDirection=e2_ia,
      each widthDirection={0,1,0},
      each r_shape=-e2_ia*(cylinderLength/2),
      each r=frame_ia.r_0,
      each R=frame_ia.R);
  equation

    defineBranch(frame_a.R, frame_ia.R);

    if kinematicConstraint then
      rRod_0 = transpose(frame_b.R.T)*(frame_b.R.T*frame_b.r_0) - transpose(
        frame_a.R.T)*(frame_a.R.T*frame_a.r_0);
    else
      rRod_0 = frame_b.r_0 - frame_a.r_0;
    end if;
    rRod_a = Frames.resolve2(frame_a.R, rRod_0);

    // Constraint equation
    if kinematicConstraint then
      0 = rRod_0*rRod_0 - rodLength*rodLength;
    end if;

    /* Determine relative Rotation R_rel_ia from frame_a to frame_ia
     and absolute rotation of frame_a.R.
  */
    eRod_a = rRod_a/rodLength;
    n2_a = cross(n1_a, eRod_a);
    length2_n2_a = n2_a*n2_a;

    assert(length2_n2_a > 1.e-10, "
A MultiBody.Joints.UniversalSpherical joint (consisting of
a universal joint and a spherical joint connected together
by a rigid rod) is in the singular configuration of the
universal joint. This means that axis 1 of the universal
joint defined via parameter \"n1_a\" is parallel to vector
\"rRod_ia\" that is directed from the origin of frame_a to the
origin of frame_b.
   You may try to use another \"n1_a\" vector. If this fails,
use instead MultiBody.Joints.SphericalSpherical, if this is
possible, because this joint aggregation does not have a
singular configuration.
");

    length_n2_a = sqrt(length2_n2_a);
    e2_a = n2_a/length_n2_a;
    e3_a = cross(eRod_a, e2_a);

    /* The statements below are an efficient implementation of the
   original equations:
     T_rel_ia = [eRod_ia, e2_ia, e3_ia]*transpose([eRod_a, e2_a, e3_a]);
     R_rel_ia = Frames.from_T(T_rel_ia,
                   Frames.TransformationMatrices.angularVelocity2(T_rel_ia, der(T_rel_ia)));
   To perform this, the rotation is split into two parts:
     R_rel_ia : Rotation object from frame_a to frame_ia
     R_rel_ia1: Rotation object from frame_a to frame_ia1
                (frame that is fixed in frame_ia such that x-axis
                is along the rod axis)
                T = transpose([eRod_a, e2_a, e3_a]; w = w_rel_ia1
     R_rel_ia2: Fixed rotation object from frame_ia1 to frame_ia
                T = [eRod_ia, e2_ia, e3_ia]; w = zeros(3)

   The difficult part is to compute w_rel_ia1:
      w_rel_ia1 = [  e3_a*der(e2_a);
                    -e3_a*der(eRod_a);
                     e2_a*der(eRod_a)]
   der(eRod_a) is directly given, since eRod_a is a function
   of translational quantities only.
      der(eRod_a) = (der(rRod_a) - eRod_a*(eRod_a*der(rRod_a)))/rodLength
      der(n2_a)   = cross(n1_a, der(eRod_a))
      der(e2_a)   = (der(n2_a) - e2_a*(e2_a*der(n2_a)))/length_n2_a
   Inserting these equations in w_rel_ia1 results in:
      e3_a*der(eRod_a) = e3_a*der(rRod_a)/rodLength       // e3_a*eRod_a = 0
      e2_a*der(eRod_a) = e2_a*der(rRod_a)/rodLength       // e2_a*eRod_a = 0
      e3_a*der(e2_a)   = e3_a*der(n2_a)/lenght_n2_a       // e3_a*e2_a = 0
                       = e3_a*cross(n1_a, der(eRod_a))/length_n2_a
                       = e3_a*cross(n1_a, der(rRod_a) - eRod_a*(eRod_a*der(rRod_a)))/(length_n2_a*rodLength)
                       = e3_a*cross(n1_a, der(rRod_a))/(length_n2_a*rodLength)
   Furthermore, we have:
     rRod_a            = resolve2(frame_a.R, rRod_0);
     der(rRod_a)       = resolve2(frame_a.R, der(rRod_0)) - cross(frame_a.R.w, rRod_a));
*/
    der_rRod_a_L = (Frames.resolve2(frame_a.R, der(rRod_0)) - cross(frame_a.R.w,
       rRod_a))/rodLength;
    w_rel_ia1 = {e3_a*cross(n1_a, der_rRod_a_L)/length_n2_a,-e3_a*der_rRod_a_L,
      e2_a*der_rRod_a_L};
    R_rel_ia1 = Frames.from_T(transpose([eRod_a, e2_a, e3_a]), w_rel_ia1);
    R_rel_ia2 = Frames.from_T([eRod_ia, e2_ia, e3_ia], zeros(3));
    R_rel_ia = Frames.absoluteRotation(R_rel_ia1, R_rel_ia2);
    /*
  T_rel_ia = [eRod_ia, e2_ia, e3_ia]*transpose([eRod_a, e2_a, e3_a]);
  R_rel_ia = Frames.from_T(T_rel_ia,
    Frames.TransformationMatrices.angularVelocity2(T_rel_ia, der(T_rel_ia)));
*/

    // Compute kinematic quantities of frame_ia
    frame_ia.r_0 = frame_a.r_0;
    frame_ia.R = Frames.absoluteRotation(frame_a.R, R_rel_ia);

    /* In the following formulas f_a, f_b, f_ia, t_a, t_b, t_ia are
     the forces and torques at frame_a, frame_b, frame_ia, respectively,
     resolved in frame_a. e_x, e_y, e_z are the unit vectors resolved in frame_a.
     Torque balance at the rod around the origin of frame_a:
       0 = t_a + t_ia + cross(rRod_a, f_b)
     with
         rRod_a = rodLength*e_x
         f_b     = -f_rod*e_x + f_b[2]*e_y + f_b[3]*e_z
     follows:
       0 = t_a + t_ia + rodLength*(f_b[2]*e_z - f_b[3]*e_y)
     The projection of t_a with respect to universal joint axes vanishes:
       n1_a*t_a = 0
       e_y*t_a = 0
     Therefore:
        0 = n1_a*t_ia + rodLength*f_b[2]*(n1_a*e_z)
        0 = e_y*t_ia - rodLength*f_b[3]
     or
        f_b = -f_rod*e_x - e_y*(n1_a*t_ia)/(rodLength*(n1_a*e_z)) + e_z*(e_y*t_ia)/rodLength
     Force balance:
        0 = f_a + f_b + f_ia
  */
    f_ia_a = Frames.resolve1(R_rel_ia, frame_ia.f);
    t_ia_a = Frames.resolve1(R_rel_ia, frame_ia.t);


      // f_b_a1 is needed in aggregation joints to solve kinematic loops analytically
    f_b_a1 = -e2_a*((n1_a*t_ia_a)/(rodLength*(n1_a*e3_a))) + e3_a*((e2_a*t_ia_a)
      /rodLength);
    f_b_a = -f_rod*eRod_a + f_b_a1;
    frame_b.f = Frames.resolveRelative(f_b_a, frame_a.R, frame_b.R);
    frame_b.t = zeros(3);
    zeros(3) = frame_a.f + f_b_a + f_ia_a;
    zeros(3) = frame_a.t + t_ia_a + cross(rRod_a, f_b_a);

    // Measure power for test purposes
    if checkTotalPower then
      totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) +
        frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + frame_ia.f*
        Frames.resolve2(frame_ia.R, der(frame_ia.r_0)) + frame_a.t*
        Frames.angularVelocity2(frame_a.R) + frame_b.t*Frames.angularVelocity2(
        frame_b.R) + frame_ia.t*Frames.angularVelocity2(frame_ia.R);
    else
      totalPower = 0;
    end if;
  end UniversalSpherical;

  model GearConstraint "Ideal 3D gearbox (arbitrary shaft directions)"
    parameter Real ratio=2 "Gear speed ratio";

    parameter MultiBody.Types.Axis n_a={1,0,0}
      "Axis of rotation of shaft a (same coordinates in frame_a, frame_b, bearing)";
    parameter MultiBody.Types.Axis n_b={1,0,0}
      "Axis of rotation of shaft b (same coordinates in frame_a, frame_b, bearing)";

    parameter Modelica.SIunits.Position r_a[3]={0,0,0}
      "Vector from frame bearing to frame_a resolved in bearing";
    parameter Modelica.SIunits.Position r_b[3]={0,0,0}
      "Vector from frame bearing to frame_b resolved in bearing";

    MultiBody.Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);
    MultiBody.Interfaces.Frame_a bearing
      annotation (extent=[-15, -120; 15, -100], rotation=90);
    annotation (
      Icon(
        Rectangle(extent=[-98, 98; 98, -98], style(color=7, fillColor=7)),
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
        Rectangle(extent=[40, 10; 100, -10], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-20, 90; 20, 70], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-100, 10; -40, -10], style(
            gradient=2,
            fillColor=8,
            fillPattern=1)),
        Text(extent=[0, 160; 0, 100], string="%name=%ratio"),
        Line(points=[-80, 20; -60, 20], style(color=0)),
        Line(points=[-80, -20; -60, -20], style(color=0)),
        Line(points=[-10, 60; 10, 60], style(color=0)),
        Line(points=[60, 20; 80, 20], style(color=0)),
        Line(points=[60, -20; 80, -20], style(color=0)),
        Line(points=[-70, -20; -70, -70; 70, -70; 70, -20], style(color=0)),
        Line(points=[0, 60; 0, -70; 0, -100], style(color=0)),
        Line(points=[-10, 100; 10, 100], style(color=0))),
      Documentation(info="<html>

<p>This ideal massless joint provides a gear constraint between
frames <tt>frame_a</tt> and <tt>frame_b</tt>. The axes of rotation
of <tt>frame_a</tt> and <tt>frame_b</tt> may be arbitrary.</p>

<p><b>Reference</b><br>
<span style=\"font-variant:small-caps\">Schweiger</span>, Christian ;
<span style=\"font-variant:small-caps\">Otter</span>, Martin:
<a href=\"http://www.modelica.org/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">Modelling
3D Mechanical Effects of 1D Powertrains</a>. In: <i>Proceedings of the 3rd International
Modelica Conference</i>. Link&ouml;ping : The Modelica Association and Link&ouml;ping University,
November 3-4, 2003, pp. 149-158</p>

</html>"),
      Diagram);
    MultiBody.Joints.ActuatedRevolute actuatedRevolute_a(n=n_a, animation=false)
      annotation (extent=[-40, -10; -60, 10], rotation=0);
    MultiBody.Joints.ActuatedRevolute actuatedRevolute_b(n=n_b, animation=false)
      annotation (extent=[40, -10; 60, 10]);
    MultiBody.Interfaces.Frame_a frame_a
      annotation (extent=[-120, -15; -100, 15], rotation=0);
    Modelica.Mechanics.Rotational.IdealGear idealGear(ratio=ratio)
      annotation (extent=[-10, 30; 10, 50]);
    MultiBody.Parts.FixedTranslation FixedTranslation1(animation=false, r=r_b)
      annotation (extent=[10, -10; 30, 10]);
    MultiBody.Parts.FixedTranslation FixedTranslation2(animation=false, r=r_a)
      annotation (extent=[-30, -10; -10, 10], rotation=180);
  equation
    connect(actuatedRevolute_a.axis, idealGear.flange_a)
      annotation (points=[-50, 10; -50, 40; -10, 40], style(color=0));
    connect(idealGear.flange_b, actuatedRevolute_b.axis)
      annotation (points=[10, 40; 50, 40; 50, 10], style(color=0));
    connect(actuatedRevolute_a.frame_a, FixedTranslation2.frame_b) annotation (
        points=[-39, 0; -35, 0; -35, 1.34707e-015; -31, 1.34707e-015], style(
          color=0, thickness=2));
    connect(FixedTranslation2.frame_a, bearing) annotation (points=[-9,
          -1.34707e-015; -4, -1.34707e-015; -4, 0; 0, 0; 0, -110], style(color=
            0, thickness=2));
    connect(FixedTranslation1.frame_a, bearing)
      annotation (points=[9, 0; 0, 0; 0, -110], style(color=0, thickness=2));
    connect(FixedTranslation1.frame_b, actuatedRevolute_b.frame_a)
      annotation (points=[31, 0; 39, 0], style(color=0, thickness=2));
    connect(frame_a, actuatedRevolute_a.frame_b)
      annotation (points=[-110, 0; -61, 0], style(color=0, thickness=2));
    connect(actuatedRevolute_b.frame_b, frame_b)
      annotation (points=[61, 0; 110, 0], style(color=0, thickness=2));
  end GearConstraint;

  package Assemblies "Joint aggregations for analytic loop handling"
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Library;

    annotation (preferedView="info", Documentation(info="<HTML>
<p>
The joints in this package are mainly designed to be used
in <b>kinematic loop</b> structures. Every component consists of
<b>3 elementary joints</b>. These joints are combined in such a
way that the kinematics of the 3 joints between frame_a and
frame_b are computed from the movement of frame_a and frame_b,
i.e., there are <b>no constraints</b> between frame_a and frame_b.
This requires to solve a <b>non-linear system of equations</b> which
is performed <b>analytically</b> (i.e., when a mathematical
solution exists, it is computed efficiently and reliably).
A detailed description how to use these joints is provided in
<a href=\"Modelica:MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling\">MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling</a>.
</p>
<p>
The assembly joints in this package are named <b>JointXYZ</b> where
<b>XYZ</b> are the first letters of the elementary joints used in the
component, in particular:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>P</b></td><td>Prismatic joint</td></tr>
  <tr><td><b>R</b></td><td>Revolute joint</td></tr>
  <tr><td><b>S</b></td><td>Spherical joint</td></tr>
  <tr><td><b>U</b></td><td>Universal joint</td></tr>
</table>
<p>
For example, JointUSR is an assembly joint consisting
of a universal, a spherical and a revolute joint.
</p>
<p> This package contains the following models:
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Model</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Joints.Assemblies.JointUPS\">JointUPS</a></b></td>
      <td> Universal - prismatic - spherical joint aggregation<br>
     <img src=\"../Images/Joints/JointUPS.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Joints.Assemblies.JointUSR\">JointUSR</a></b></td>
      <td> Universal - spherical - revolute joint aggregation<br>
     <img src=\"../Images/Joints/JointUSR.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Joints.Assemblies.JointUSP\">JointUSP</a></b></td>
      <td> Universal - spherical - prismatic joint aggregation<br>
     <img src=\"../Images/Joints/JointUSP.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Joints.Assemblies.JointSSR\">JointSSR</a></b></td>
      <td> Spherical - spherical - revolute joint aggregation
           with an optional mass point at the rod connecting
           the two spherical joints<br>
     <img src=\"../Images/Joints/JointSSR.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Joints.Assemblies.JointSSP\">JointSSP</a></b></td>
      <td> Spherical - spherical - prismatic joint aggregation
           with an optional mass point at the rod connecting
           the two spherical joints<br>
     <img src=\"../Images/Joints/JointSSP.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Joints.Assemblies.JointRRR\">JointRRR</a></b></td>
      <td> Revolute - revolute - revolute joint aggregation for planar loops<br>
     <img src=\"../Images/Joints/JointRRR.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Joints.Assemblies.JointRRP\">JointRRP</a></b></td>
      <td> Revolute - revolute - prismatic joint aggregation for planar loops<br>
     <img src=\"../Images/Joints/JointRRP.png\">
      </td>
  </tr>
</table>
<p>
Note, no component of this package has potential states, since the
components are designed in such a way that the generalized coordinates
of the used elementary joints are computed from the frame_a and frame_b
coordinates. Still, it is possible to use the components in a
tree structure. In this case states are selected from bodies that are
connected to the frame_a or frame_b side of the component.
In most cases this gives a less efficient solution, as if elementary
joints of package MultiBody.Joints would be used directly.
</p>
<p>
The analytic handling of kinematic loops by using joint aggregations
with 6 degrees of freedom as provided in this package, is a <b>new</b>
methodology. It is based on a more general method for solving
non-linear equations of kinematic loops developed by Woernle and
Hiller. An automatic application of this more general method
is difficult, and a manual application is only suited for
specialists in this field. The method introduced here is a
compromize: It can be quite easily applied by an end user, but
for a smaller class of kinematic loops. The method of the \"characteristic
pair of joints\" from Woernle and Hiller is described in:
</p>
<dl>
<dt>Woernle C.:</dt>
<dd><b>Ein systematisches Verfahren zur Aufstellung der geometrischen
    Schliessbedingungen in kinematischen Schleifen mit Anwendung
    bei der R&uuml;ckw&auml;rtstransformation f&uuml;r
    Industrieroboter.</b><br>
    Fortschritt-Berichte VDI, Reihe 18, Nr. 59, Duesseldorf: VDI-Verlag 1988,
    ISBN 3-18-145918-6.<br>&nbsp;</dd>
<dt>Hiller M., and Woernle C.:</dt
<dd><b>A Systematic Approach for Solving the Inverse Kinematic
    Problem of Robot Manipulators</b>.<br>
    Proceedings 7th World Congress Th. Mach. Mech., Sevilla 1987. </dd>
</dl>
</HTML>"));

    model JointUPS
      "Universal - prismatic - spherical joint aggregation (no constraints, no potential states)"


      import SI = Modelica.SIunits;
      extends Interfaces.PartialTwoFrames;
      MultiBody.Interfaces.Frame_a frame_ia
        annotation (extent=[-95, 110; -65, 90], rotation=-90);
      MultiBody.Interfaces.Frame_b frame_ib
        annotation (extent=[65, 120; 95, 100], rotation=-90);
      parameter Boolean animation=true "= true, if animation shall be enabled";
      parameter Boolean showUniversalAxes=true
        " = true, if universal joint shall be visualized with two cylinders, otherwise with a sphere (provided animation=true)";
      parameter MultiBody.Types.Axis n1_a={0,0,1}
        "Axis 1 of universal joint resolved in frame_a (axis 2 is orthogonal to axis 1 and to line from universal to spherical joint)";
      parameter SI.Position nAxis_ia[3]={1,0,0}
        "Axis vector along line from origin of frame_a to origin of frame_b, resolved in frame_ia"
        annotation (Evaluate=true);
      parameter SI.Position s_offset=0
        "Relative distance offset (distance between frame_a and frame_b = s(t) + s_offset)";
      parameter SI.Diameter sphereDiameter=world.defaultJointLength
        "|Animation|if animation = true| Diameter of spheres representing the spherical joints";
      parameter MultiBody.Types.Color sphereColor=Types.Defaults.JointColor
        "|Animation|if animation = true| Color of spheres representing the spherical joints";
      parameter SI.Diameter axisDiameter=sphereDiameter/Types.Defaults.
          JointRodDiameterFraction
        "|Animation|if animation = true| Diameter of cylinder on the connecting line from frame_a to frame_b";
      parameter MultiBody.Types.Color axisColor=Types.Defaults.SensorColor
        "|Animation|if animation = true| Color of cylinder on the connecting line from frame_a to frame_b";
      parameter SI.Distance cylinderLength=world.defaultJointLength
        "|Animation|if animation = true and showUniversalAxes| Length of cylinders representing the two universal joint axes";
      parameter SI.Distance cylinderDiameter=world.defaultJointWidth
        "|Animation|if animation = true and showUniversalAxes| Diameter of cylinders representing the two universal joint axes";
      parameter MultiBody.Types.Color cylinderColor=Types.Defaults.JointColor
        "|Animation|if animation = true and showUniversalAxes| Color of cylinders representing the two universal joint axes";

      parameter Boolean checkTotalPower=false
        "|Advanced|| = true, if total power flowing into this component shall be determined (must be zero)";
      final parameter Real eAxis_ia[3]=Frames.normalize(nAxis_ia)
        "Unit vector from origin of frame_a to origin of frame_b, resolved in frame_ia";
      final parameter Real e2_ia[3]=Frames.normalize(cross(n1_a, eAxis_ia))
        "Unit vector in direction of second rotation axis of universal joint, resolved in frame_ia";
      final parameter Real e3_ia[3]=cross(eAxis_ia, e2_ia)
        "Unit vector perpendicular to eAxis_ia and e2_ia, resolved in frame_ia";
      SI.Position s
        "Relative distance between frame_a and frame_b along axis nAxis = s + s_offset";
      SI.Force f "= axis.f (driving force in the axis; = -bearing.f)";
      SI.Length axisLength "Distance between frame_a and frame_b";
      SI.Power totalPower
        "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";
      annotation (
        preferedView="info",
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.19,
          y=0.01,
          width=0.81,
          height=0.81),
        Documentation(info="<html>
<p>
This component consists of a <b>universal</b> joint at frame_a,
a <b>spherical</b> joint at frame_b and a <b>prismatic</b> joint along the
line connecting the origin of frame_a and the origin of frame_b,
see the default animation in the following figure (the axes vectors
are not part of the default animation):
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Joints/JointUPS.png\" ALT=\"model Joints.Assemblies.JointUPS\">
</p>
<p>
This joint aggregation has no mass and no inertia and
introduces neither constraints nor potential state variables.
It is especially useful to build up more complicated force elements
where the mass and/or inertia of the force element shall be taken
into account.
</p>
<p>
The universal joint is defined in the following way:
<p>
<ul>
<li> The rotation <b>axis</b> of revolute joint <b>1</b> is along parameter
     vector n1_a which is fixed in frame_a.<li>
<li> The rotation <b>axis</b> of revolute joint <b>2</b> is perpendicular to
     axis 1 and to the line connecting the universal and the spherical joint.
</ul>
<p>
The definition of axis 2 of the universal joint is performed according
to the most often occuring case. In a future release, axis 2 might
be explicitly definable via a parameter. However, the treatment is much more
complicated and the number of operations is considerably higher,
if axis 2 is not orthogonal to axis 1 and to the connecting rod.
</p>
<p>
Note, there is a <b>singularity</b> when axis 1 and the connecting line are parallel
to each other. Therefore, if possible n1_a should be selected in such a way that it
is perpendicular to nAxis_ia in the initial configuration (i.e., the
distance to the singularity is as large as possible).
</p>
<p>
An additional <b>frame_ia</b> is present. It is <b>fixed</b> on the line
connecting the universal and the spherical joint at the
origin of <b>frame_a</b>. The placement of frame_ia on this line
is implicitly defined by the universal joint (frame_a and frame_ia coincide
when the angles of the two revolute joints of the universal joint are zero)
and by parameter vector <b>nAxis_ia</b>, an axis vector directed
along the line from the origin of frame_a to the spherical joint,
resolved in frame_<b>ia</b>.
</p
<p>
An additional <b>frame_ib</b> is present. It is <b>fixed</b> in the line
connecting the prismatic and the spherical joint at the
origin of <b>frame_b</b>.
It is always parallel to <b>frame_ia</b>.
</p>
<p>
Note, this joint aggregation can be used in cases where
in reality a rod with spherical joints at each end are present.
Such a system has an additional degree of freedom to rotate
the rod along its axis. In practice this rotation is usually
of no interested and is mathematically removed by replacing one
of the spherical joints by a universal joint.
</p>
<p>
The easiest way to define the parameters of this joint is by moving the
MultiBody system in a <b>reference configuration</b> where <b>all frames</b>
of all components are <b>parallel</b> to each other (alternatively,
at least frame_a, frame_ia and frame_ib of the JointUSP joint
should be parallel to each other when defining an instance of this
component).
</p>
</html> "),
        Icon(
          Text(
            extent=[-139, -53; 153, -109],
            style(color=3),
            string="%name"),
          Ellipse(extent=[-100, -40; -19, 40], style(
              color=9,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[-90, -30; -29, 29], style(
              color=9,
              fillColor=7,
              fillPattern=1)),
          Rectangle(extent=[-60, 41; -9, -44], style(color=7, fillColor=7)),
          Line(points=[-60, 40; -60, -40], style(
              color=0,
              thickness=2,
              fillColor=7,
              fillPattern=1)),
          Ellipse(extent=[-83, -17; -34, 21], style(
              color=9,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[-74, -12; -40, 15], style(
              color=9,
              fillColor=7,
              fillPattern=1)),
          Polygon(points=[-72, -20; -89, 3; -69, 25; -45, 27; -72, -20], style(
              pattern=0,
              fillColor=7,
              fillPattern=1)),
          Line(points=[-60, 40; -60, -10], style(
              color=0,
              thickness=2,
              fillColor=7,
              fillPattern=1)),
          Line(points=[-118, 28; -42, 94], style(
              color=0,
              pattern=0,
              fillColor=7,
              fillPattern=1)),
          Line(points=[-49, 20; -69, -15], style(
              color=0,
              thickness=2,
              fillColor=7,
              fillPattern=1)),
          Ellipse(extent=[44, 14; 73, -14], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Ellipse(extent=[20, -40; 100, 40], style(
              color=8,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[30, -30; 90, 30], style(
              color=8,
              fillColor=7,
              fillPattern=1)),
          Rectangle(extent=[-22, 45; 40, -43], style(
              color=7,
              fillColor=7,
              fillPattern=1)),
          Ellipse(extent=[45, 14; 74, -14], style(
              color=0,
              gradient=3,
              fillColor=8)),
          Text(
            extent=[-139, 128; -89, 92],
            style(color=10),
            string="ia"),
          Line(points=[-40, 0; -40, 89; -80, 89; -80, 100], style(color=10,
                thickness=2)),
          Text(
            extent=[105, 124; 153, 89],
            style(color=10),
            string="ib"),
          Rectangle(extent=[-35, -13; -6, 14], style(pattern=0, fillColor=8)),
          Rectangle(extent=[-35, 14; -6, 18], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[-6, -7; 46, 6], style(pattern=0, fillColor=8)),
          Rectangle(extent=[-6, 6; 46, 10], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Line(points=[-6, -13; -6, 18], style(color=0)),
          Line(points=[60, -1; 60, 90; 80, 90; 80, 100], style(color=10,
                thickness=2)),
          Line(points=[60, 90; 30, 90; 30, 89], style(color=58)),
          Line(points=[-30, 70; 10, 70], style(color=0, fillColor=10)),
          Polygon(points=[30, 70; 10, 76; 10, 63; 30, 70], style(color=10,
                fillColor=10))),
        Diagram(
          Line(points=[-60, -70; 46, -70]),
          Polygon(points=[60, -70; 45, -64; 45, -76; 60, -70], style(
              color=3,
              fillColor=3,
              fillPattern=1)),
          Text(extent=[-62, -73; 62, -97], string="rAxis"),
          Ellipse(extent=[-100, -40; -19, 40], style(
              color=9,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[-90, -30; -29, 29], style(
              color=9,
              fillColor=7,
              fillPattern=1)),
          Rectangle(extent=[-60, 41; -19, -41], style(color=7, fillColor=7)),
          Line(points=[-60, 40; -60, -40], style(
              color=0,
              thickness=2,
              fillColor=7,
              fillPattern=1)),
          Ellipse(extent=[-83, -17; -34, 21], style(
              color=9,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[-74, -12; -40, 15], style(
              color=9,
              fillColor=7,
              fillPattern=1)),
          Polygon(points=[-72, -20; -89, 3; -69, 25; -45, 27; -72, -20], style(
              pattern=0,
              fillColor=7,
              fillPattern=1)),
          Line(points=[-60, 40; -60, -10], style(
              color=0,
              thickness=2,
              fillColor=7,
              fillPattern=1)),
          Line(points=[-118, 28; -42, 94], style(
              color=0,
              pattern=0,
              fillColor=7,
              fillPattern=1)),
          Line(points=[-49, 20; -69, -15], style(
              color=0,
              thickness=2,
              fillColor=7,
              fillPattern=1)),
          Line(points=[-40, 0; -40, 90; -80, 90; -80, 100], style(color=10,
                thickness=2)),
          Polygon(points=[7, -1; -5, 2; -5, -4; 7, -1], style(fillPattern=7)),
          Line(points=[-50, 19; -30, 57], style(fillColor=0, fillPattern=1)),
          Text(
            extent=[-24, 74; 7, 53],
            style(gradient=0, fillPattern=0),
            string="e2"),
          Polygon(points=[-25, 64; -33, 56; -27, 53; -25, 64], style(
                fillPattern=7)),
          Line(points=[-60, 41; -60, 65], style(fillColor=0, fillPattern=1)),
          Polygon(points=[-60, 75; -64, 63; -56, 63; -60, 75], style(
                fillPattern=7)),
          Text(
            extent=[-96, 82; -65, 61],
            style(gradient=0, fillPattern=0),
            string="n1"),
          Line(points=[-60, -40; -60, -72]),
          Ellipse(extent=[20, -40; 100, 40], style(
              color=8,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[30, -30; 90, 30], style(
              color=8,
              fillColor=7,
              fillPattern=1)),
          Rectangle(extent=[-22, 45; 40, -43], style(
              color=7,
              fillColor=7,
              fillPattern=1)),
          Ellipse(extent=[45, 14; 74, -14], style(
              color=0,
              gradient=3,
              fillColor=10)),
          Line(points=[60, 0; 60, -74]),
          Rectangle(extent=[-35, 14; -6, 18], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[-35, -13; -6, 14], style(pattern=0, fillColor=8)),
          Rectangle(extent=[-6, 6; 46, 10], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[-6, -7; 46, 6], style(pattern=0, fillColor=8)),
          Line(points=[-6, -13; -6, 18], style(color=0)),
          Text(
            extent=[-34, -7; -3, -28],
            style(gradient=0, fillPattern=0),
            string="nAxis"),
          Line(points=[-61, 1; -2, 1], style(fillColor=0, fillPattern=1)),
          Polygon(points=[10, 1; -2, 4; -2, -2; 10, 1], style(fillPattern=7)),
          Line(points=[60, 90; 30, 90; 30, 89], style(color=58)),
          Line(points=[60, -1; 60, 90; 80, 90; 80, 100], style(color=10,
                thickness=2)),
          Text(extent=[-20, 116; -5, 101], string="f"),
          Polygon(points=[-20, 103; -30, 100; -20, 97; -20, 103], style(color=3,
                 fillColor=3)),
          Polygon(points=[21, 103; 31, 100; 21, 97; 21, 103], style(color=3,
                fillColor=3)),
          Line(points=[9, 100; 31, 100], style(color=3)),
          Text(extent=[7, 116; 22, 101], string="f"),
          Polygon(points=[20, 97; 30, 94; 20, 91; 20, 97], style(color=10,
                fillColor=10)),
          Line(points=[-30, 94; 30, 94], style(color=10)),
          Line(points=[-19, 100; -4, 100], style(color=3)),
          Text(
            extent=[-17, 93; 20, 80],
            style(color=10),
            string="s")));

    protected
      SI.Force f_c_a[3] "frame_ia.f resolved in frame_a";
      SI.Torque t_cd_a[3] "frame_ia.t + frame_ib.t resolved in frame_a";
      SI.Force f_bd_a[3] "frame_b.f + frame_ib.f resolved in frame_a";
      SI.Position rAxis_0[3]
        "Position vector from origin of frame_a to origin of frame_b resolved in world frame";
      SI.Position rAxis_a[3]
        "Position vector from origin of frame_a to origin of frame_b resolved in frame_a";
      Real eAxis_a[3]
        "Unit vector in direction of rAxis_a, resolved in frame_a";
      Real e2_a[3]
        "Unit vector in direction of second rotation axis of universal joint, resolved in frame_a";
      Real e3_a[3]
        "Unit vector perpendicular to eAxis_a and e2_a, resolved in frame_a";
      Real n2_a[3]
        "Vector in direction of second rotation axis of universal joint, resolved in frame_a";
      Real length2_n2_a(unit="m2") "Square of length of vector n2_a";
      SI.Length length_n2_a "Length of vector n2_a";
      Real der_rAxis_a_L[3] "= der(rAxis_a)/axisLength";
      SI.AngularVelocity w_rel_ia1[3];
      Frames.Orientation R_ia1_a;
      Frames.Orientation R_ia2_a;
      Frames.Orientation R_ia_a "Rotation from frame_a to frame_ia";
      // Real T_ia_a[3, 3] "Transformation matrix from frame_a to frame_ia";

      parameter Integer ndim=if world.enableAnimation and animation then 1
           else 0;
      parameter Integer ndim1=if world.enableAnimation and animation and not
          showUniversalAxes then 1 else 0;
      parameter Integer ndim2=if world.enableAnimation and animation and
          showUniversalAxes then 1 else 0;
      Visualizers.Advanced.Shape axisCylinder[ndim](
        each shapeType="cylinder",
        each color=axisColor,
        each length=axisLength,
        each width=axisDiameter,
        each height=axisDiameter,
        each lengthDirection=eAxis_ia,
        each widthDirection=e2_ia,
        each r=frame_ia.r_0,
        each R=frame_ia.R);
      Visualizers.Advanced.Shape sphericalShape_b[ndim](
        each shapeType="sphere",
        each color=sphereColor,
        each length=sphereDiameter,
        each width=sphereDiameter,
        each height=sphereDiameter,
        each lengthDirection={1,0,0},
        each widthDirection={0,1,0},
        each r_shape={-0.5,0,0}*sphereDiameter,
        each r=frame_b.r_0,
        each R=frame_b.R);
      Visualizers.Advanced.Shape sphericalShape_a[ndim1](
        each shapeType="sphere",
        each color=sphereColor,
        each length=sphereDiameter,
        each width=sphereDiameter,
        each height=sphereDiameter,
        each lengthDirection={1,0,0},
        each widthDirection={0,1,0},
        each r_shape={-0.5,0,0}*sphereDiameter,
        each r=frame_a.r_0,
        each R=frame_a.R);
      Visualizers.Advanced.Shape universalShape1[ndim2](
        each shapeType="cylinder",
        each color=cylinderColor,
        each length=cylinderLength,
        each width=cylinderDiameter,
        each height=cylinderDiameter,
        each lengthDirection=n1_a,
        each widthDirection={0,1,0},
        each r_shape=-n1_a*(cylinderLength/2),
        each r=frame_a.r_0,
        each R=frame_a.R);
      Visualizers.Advanced.Shape universalShape2[ndim2](
        each shapeType="cylinder",
        each color=cylinderColor,
        each length=cylinderLength,
        each width=cylinderDiameter,
        each height=cylinderDiameter,
        each lengthDirection=e2_ia,
        each widthDirection={0,1,0},
        each r_shape=-e2_ia*(cylinderLength/2),
        each r=frame_ia.r_0,
        each R=frame_ia.R);
    public
      Modelica.Mechanics.Translational.Interfaces.Flange_b bearing
        annotation (extent=[-30, 110; -50, 90]);
      Modelica.Mechanics.Translational.Interfaces.Flange_a axis
        annotation (extent=[30, 110; 50, 90]);
    equation
      defineBranch(frame_a.R, frame_ia.R);
      defineBranch(frame_ia.R, frame_ib.R);

      // Translational flanges
      axisLength = s + s_offset;
      bearing.s = 0;
      axis.s = s;
      axis.f = f;

      // Position vector rAxis from frame_a to frame_b
      rAxis_0 = frame_b.r_0 - frame_a.r_0;
      rAxis_a = Frames.resolve2(frame_a.R, rAxis_0);

      /* Determine relative Rotation R_rel_c from frame_a to frame_ia
     and absolute rotation of frame_a.R.
  */
      axisLength = sqrt(rAxis_0*rAxis_0);
      assert(axisLength > 1.0e-15, "
Distance between frame_a and frame_b of a JointUPS joint
became zero. This is not allowed. If this occurs during
initialization, the initial conditions are probably wrong.");

      eAxis_a = rAxis_a/axisLength;
      n2_a = cross(n1_a, eAxis_a);
      length2_n2_a = n2_a*n2_a;
      assert(noEvent(length2_n2_a > 1.e-10), "
A MultiBody.Joints.Assemblies.JointUPS joint (consisting of
a universal, prismatic and spherical joint) is in the singular
configuration of the universal joint. This means that axis 1 of
the universal joint defined via parameter \"n1_a\" is parallel to vector
\"eAxis_ia\" that is directed from the origin of frame_a to the
origin of frame_b. You may try to use another \"n1_a\" vector.
");
      length_n2_a = sqrt(length2_n2_a);
      e2_a = n2_a/length_n2_a;
      e3_a = cross(eAxis_a, e2_a);

      /* The statements below are an efficient implementation of the
     original equations:
       T_ia_a = [eAxis_ia, e2_ia, e3_ia]*transpose([eAxis_a, e2_a, e3_a]);
       R_ia_a = Frames.from_T(T_ia_a,
                     Frames.TransformationMatrices.angularVelocity2(T_ia_a, der(T_ia_a)));
   To perform this, the rotation is split into two parts:
     R_ia_a : Rotation object from frame_a to frame_ia
     R_ia1_a: Rotation object from frame_a to frame_ia1
                (frame that is fixed in frame_ia such that x-axis
                is along the rod axis)
                T = transpose([eAxis_a, e2_a, e3_a]; w = w_rel_ia1
     R_ia2_a: Fixed rotation object from frame_ia1 to frame_ia
                T = [eAxis_a, e2_ia, e3_ia]; w = zeros(3)

   The difficult part is to compute w_rel_ia1:
      w_rel_ia1 = [  e3_a*der(e2_a);
                    -e3_a*der(eAxis_a);
                     e2_a*der(eAxis_a)]
   der(eAxis_a) is directly given, since eAxis_a is a function
   of translational quantities only.
      der(eAxis_a) = (der(rAxis_a) - eAxis_a*(eAxis_a*der(rAxis_a)))/axisLength
      der(n2_a)    = cross(n1_a, der(eAxis_a))
      der(e2_a)    = (der(n2_a) - e2_a*(e2_a*der(n2_a)))/length_n2_a
   Inserting these equations in w_rel_ia1 results in:
      e3_a*der(eAxis_a) = e3_a*der(rAxis_a)/axisLength       // e3_a*eAxis_a = 0
      e2_a*der(eAxis_a) = e2_a*der(rAxis_a)/axisLength       // e2_a*eAxis_a = 0
      e3_a*der(e2_a)    = e3_a*der(n2_a)/lenght_n2_a       // e3_a*e2_a = 0
                        = e3_a*cross(n1_a, der(eAxis_a))/length_n2_a
                        = e3_a*cross(n1_a, der(rAxis_a) - eAxis_a*(eAxis_a*der(rAxis_a)))/(length_n2_a*axisLength)
                        = e3_a*cross(n1_a, der(rAxis_a))/(length_n2_a*axisLength)
   Furthermore, we have:
     rAxis_a      = resolve2(frame_a.R, rAxis_0);
     der(rAxis_a) = resolve2(frame_a.R, der(rAxis_0)) - cross(frame_a.R.w, rAxis_a));
*/
      der_rAxis_a_L = (Frames.resolve2(frame_a.R, der(rAxis_0)) - cross(frame_a
        .R.w, rAxis_a))/axisLength;
      w_rel_ia1 = {e3_a*cross(n1_a, der_rAxis_a_L)/length_n2_a,-e3_a*
        der_rAxis_a_L,e2_a*der_rAxis_a_L};
      R_ia1_a = Frames.from_T(transpose([eAxis_a, e2_a, e3_a]), w_rel_ia1);
      R_ia2_a = Frames.from_T([eAxis_ia, e2_ia, e3_ia], zeros(3));
      R_ia_a = Frames.absoluteRotation(R_ia1_a, R_ia2_a);
      /*
  T_ia_a = [eAxis_ia, e2_ia, e3_ia]*transpose([eAxis_a, e2_a, e3_a]);
  R_ia_a = Frames.from_T(T_ia_a, Frames.TransformationMatrices.angularVelocity2
    (T_ia_a, der(T_ia_a)));
*/

      // Compute kinematic quantities of frame_ia and frame_ib
      frame_ia.r_0 = frame_a.r_0;
      frame_ib.r_0 = frame_b.r_0;
      frame_ia.R = Frames.absoluteRotation(frame_a.R, R_ia_a);
      frame_ib.R = frame_ia.R;

      /* In the following formulas f_a, f_b, f_ia, f_ib, t_a, t_b, t_ia, t_ib are
     the forces and torques at frame_a, frame_b, frame_ia, frame_ib respectively,
     resolved in frame_a. eAxis, e2, e3 are the unit vectors resolved in frame_a.
     Torque balance at the rod around the origin of frame_a:
       0 = t_a + t_ia + t_ib + cross(rAxis, (f_b+f_ib))
     with
         rAxis = axisLength*eAxis
         f_bd  = f_b + f_ib
         f_bd  = f*eAxis + f_bd[2]*e2 + f_bd[3]*e3
     follows:
         0 = t_a + t_ia + axisLength*(f_bd[2]*e_z - f_bd[3]*e_y)
     The projection of t_a with respect to universal joint axes vanishes:
       e1*t_a = 0
       e2*t_a = 0
     Therefore:
        0 = e1*(t_ia + t_ib) + axisLength*f_bd[2]*(e1*e3)
        0 = e2*(t_ia + t_ib) - axisLength*f_bd[3]
     or
        f_bd = f*eAxis - e2*(e1*(t_ia+t_ib))/(axisLength*(e1*e3)) +
                e3*(e2*(t_ia+t_ib))/axisLength
     Force balance:
        0 = f_a + f_bd + f_ia
  */
      f_c_a = Frames.resolve1(R_ia_a, frame_ia.f);
      t_cd_a = Frames.resolve1(R_ia_a, frame_ia.t + frame_ib.t);
      f_bd_a = -eAxis_a*f - e2_a*((n1_a*t_cd_a)/(axisLength*(n1_a*e3_a))) +
        e3_a*((e2_a*t_cd_a)/axisLength);
      zeros(3) = frame_b.f + Frames.resolveRelative(frame_ib.f, frame_ib.R,
        frame_b.R) - Frames.resolveRelative(f_bd_a, frame_a.R, frame_b.R);
      zeros(3) = frame_b.t;
      zeros(3) = frame_a.f + f_c_a + f_bd_a;
      zeros(3) = frame_a.t + t_cd_a + cross(rAxis_a, f_bd_a);

      // Measure power for test purposes
      if checkTotalPower then
        totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) +
          frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + frame_ia.f*
          Frames.resolve2(frame_ia.R, der(frame_ia.r_0)) + frame_ib.f*
          Frames.resolve2(frame_ib.R, der(frame_ib.r_0)) + frame_a.t*
          Frames.angularVelocity2(frame_a.R) + frame_b.t*
          Frames.angularVelocity2(frame_b.R) + frame_ia.t*
          Frames.angularVelocity2(frame_ia.R) + frame_ib.t*
          Frames.angularVelocity2(frame_ib.R) + axis.f*der(axis.s) + bearing.f*
          der(bearing.s);
      else
        totalPower = 0;
      end if;
    end JointUPS;

    model JointUSR
      "Universal - spherical - revolute joint aggregation (no constraints, no potential states)"


      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;

      extends MultiBody.Interfaces.PartialTwoFrames;
      MultiBody.Interfaces.Frame_a frame_ia
        annotation (extent=[-64, 120; -94, 100], rotation=-270);
      MultiBody.Interfaces.Frame_b frame_ib
        annotation (extent=[65, 120; 95, 100], rotation=-90);
      MultiBody.Interfaces.Frame_b frame_im
        annotation (extent=[-15, 120; 15, 100], rotation=-90);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis
        annotation (extent=[120, 90; 100, 70]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_b bearing
        annotation (extent=[100, 50; 120, 30]);

      parameter Boolean animation=true "= true, if animation shall be enabled";
      parameter Boolean showUniversalAxes=true
        " = true, if universal joint shall be visualized with two cylinders, otherwise with a sphere (provided animation=true)";
      parameter MultiBody.Types.Axis n1_a={0,0,1}
        "Axis 1 of universal joint fixed and resolved in frame_a (axis 2 is orthogonal to axis 1 and to rod 1)"
        annotation (Evaluate=true);
      parameter MultiBody.Types.Axis n_b={0,0,1}
        "Axis of revolute joint fixed and resolved in frame_b"
        annotation (Evaluate=true);
      parameter SI.Position rRod1_ia[3]={1,0,0}
        "Vector from origin of frame_a to spherical joint, resolved in frame_ia"
        annotation (Evaluate=true);
      parameter SI.Position rRod2_ib[3]={-1,0,0}
        "Vector from origin of frame_ib to spherical joint, resolved in frame_ib";
      parameter Cv.NonSIunits.Angle_deg phi_offset=0
        "Relative angle offset of revolute joint (angle = phi(t) + from_deg(phi_offset))";
      parameter Cv.NonSIunits.Angle_deg phi_guess=0
        "Select the configuration such that at initial time |phi(t0) - from_deg(phi_guess)| is minimal";
      parameter SI.Diameter sphereDiameter=world.defaultJointLength
        "|Animation|if animation = true| Diameter of the spheres representing the universal and the spherical joint";
      parameter MultiBody.Types.Color sphereColor=MultiBody.Types.Defaults.
          JointColor
        "|Animation|if animation = true| Color of the spheres representing the universal and the spherical joint";
      parameter SI.Diameter rod1Diameter=sphereDiameter/Types.Defaults.
          JointRodDiameterFraction
        "|Animation|if animation = true| Diameter of rod 1 connecting the universal and the spherical joint";
      parameter MultiBody.Types.Color rod1Color=MultiBody.Types.Defaults.
          RodColor
        "|Animation|if animation = true| Color of rod 1 connecting the universal and the spherical joint";

      parameter SI.Diameter rod2Diameter=rod1Diameter
        "|Animation|if animation = true| Diameter of rod 2 connecting the revolute and the spherical joint";
      parameter MultiBody.Types.Color rod2Color=rod1Color
        "|Animation|if animation = true| Color of rod 2 connecting the revolute and the spherical joint";
      parameter SI.Diameter revoluteDiameter=world.defaultJointWidth
        "|Animation|if animation = true| Diameter of cylinder representing the revolute joint";
      parameter SI.Distance revoluteLength=world.defaultJointLength
        "|Animation|if animation = true| Length of cylinder representing the revolute joint";
      parameter MultiBody.Types.Color revoluteColor=MultiBody.Types.Defaults.
          JointColor
        "|Animation|if animation = true| Color of cylinder representing the revolute joint";
      parameter SI.Distance cylinderLength=world.defaultJointLength
        "|Animation|if animation = true and showUniversalAxes| Length of cylinders representing the two universal joint axes";
      parameter SI.Distance cylinderDiameter=world.defaultJointWidth
        "|Animation|if animation = true and showUniversalAxes| Diameter of cylinders representing the two universal joint axes";
      parameter MultiBody.Types.Color cylinderColor=Types.Defaults.JointColor
        "|Animation|if animation = true and showUniversalAxes| Color of cylinders representing the two universal joint axes";

      parameter Boolean checkTotalPower=false
        "|Advanced|| = true, if total power flowing into this component shall be determined (must be zero)";
      final parameter Real eRod1_ia[3]=rod1.eRod_ia
        "Unit vector from origin of frame_a to origin of spherical joint, resolved in frame_ia";
      final parameter Real e2_ia[3]=rod1.e2_ia
        "Unit vector in direction of axis 2 of universal joint, resolved in frame_ia";
      final parameter SI.Distance rod1Length=rod1.rodLength
        "Length of rod 1 (= distance between universal and spherical joint";
      SI.Power totalPower
        "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";
      SI.Position aux
        "Denominator used to compute force in rod connecting universal and spherical joint";
      annotation (
        preferedView="info",
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.19,
          y=0.01,
          width=0.81,
          height=0.81),
        Documentation(info="<html>
<p>
This component consists of a <b>universal</b> joint at frame_a, a <b>revolute</b>
joint at frame_b and a <b>spherical</b> joint which is connected via <b>rod1</b>
to the universal and via <b>rod2</b> to the revolute joint, see the default
animation in the following figure (the axes vectors are not part of the
default animation):
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Joints/JointUSR.png\" ALT=\"model Joints.Assemblies.JointUSR\">
</p>
<p>
This joint aggregation has no mass and no inertia and
introduces neither constraints nor potential state variables.
It should be used in kinematic loops whenever possible since
the non-linear system of equations introduced by this joint aggregation
is solved <b>analytically</b> (i.e., a solution is always computed, if a
unique solution exists).
</p>
<p>
The universal joint is defined in the following way:
<p>
<ul>
<li> The rotation <b>axis</b> of revolute joint <b>1</b> is along parameter
     vector n1_a which is fixed in frame_a.<li>
<li> The rotation <b>axis</b> of revolute joint <b>2</b> is perpendicular to
     axis 1 and to the line connecting the universal and the spherical joint
     (= rod 1).
</ul>
<p>
The definition of axis 2 of the universal joint is performed according
to the most often occuring case. In a future release, axis 2 might
be explicitly definable via a parameter. However, the treatment is much more
complicated and the number of operations is considerably higher,
if axis 2 is not orthogonal to axis 1 and to the connecting rod.
</p>
<p>
Note, there is a <b>singularity</b> when axis 1 and the connecting rod are parallel
to each other. Therefore, if possible n1_a should be selected in such a way that it
is perpendicular to rRod1_ia in the initial configuration (i.e., the
distance to the singularity is as large as possible).
</p>
<p>
The rest of this joint aggregation is defined by the following parameters:
</p>
<ul>
<li> The position of the spherical joint with respect to the universal
     joint is defined by vector <b>rRod1_ia</b>. This vector is directed from
     frame_a to the spherical joint and is resolved in frame_ia
     (it is most simple to select frame_ia such that it is parallel to
     frame_a in the reference or initial configuration).</li>
<li> The position of the spherical joint with respect to the revolute
     joint is defined by vector <b>rRod2_ib</b>. This vector is directed from
     the inner frame of the revolute joint (frame_ib or revolute.frame_a)
     to the spherical joint and is resolved in frame_ib (note, that frame_ib
     and frame_b are parallel to each other).</li>
<li> The axis of rotation of the revolute joint is defined by axis
     vector <b>n_b</b>. It is fixed and resolved in frame_b.</li>
<li> When specifying this joint aggregation with the definitions above, <b>two</b>
     different <b>configurations</b> are possible. Via parameter <b>phi_guess</b>
     a guess value for revolute.phi(t0) at the initial time t0 is given. The configuration
     is selected that is closest to phi_guess (|revolute.phi - phi_guess| is minimal).
</ul>
<p>
An additional <b>frame_ia</b> is present. It is <b>fixed</b> in the rod
connecting the universal and the spherical joint at the
origin of <b>frame_a</b>. The placement of frame_ia on the rod
is implicitly defined by the universal joint (frame_a and frame_ia coincide
when the angles of the two revolute joints of the universal joint are zero)
and by parameter vector <b>rRod1_ia</b>, the position vector
from the origin of frame_a to the spherical joint, resolved in frame_<b>ia</b>.
</p
<p>
An additional <b>frame_ib</b> is present. It is <b>fixed</b> in the rod
connecting the revolute and the spherical joint at the side of the revolute
joint that is connected to this rod (= rod2.frame_a = revolute.frame_a).
</p>
<p>
An additional <b>frame_im</b> is present. It is <b>fixed</b> in the rod
connecting the revolute and the spherical joint at the side of the spherical
joint that is connected to this rod (= rod2.frame_b).
It is always parallel to <b>frame_ib</b>.
</p>
<p>
The easiest way to define the parameters of this joint is by moving the
MultiBody system in a <b>reference configuration</b> where <b>all frames</b>
of all components are <b>parallel</b> to each other (alternatively,
at least frame_a and frame_ia of the JointUSR joint
should be parallel to each other when defining an instance of this
component).
</p>
<p>
In the public interface of the JointUSR joint, the following
(final) <b>parameters</b> are provided:
</p>
<pre>
  <b>parameter</b> Real rod1Length(unit=\"m\")  \"Length of rod 1\";
  <b>parameter</b> Real eRod1_ia[3] \"Unit vector along rod 1, resolved in frame_ia\";
  <b>parameter</b> Real e2_ia  [3]  \"Unit vector along axis 2, resolved in frame_ia\";
</pre>
<p>
This allows a more convenient definition of data which is related to rod 1.
For example, if a box shall be connected at frame_ia directing from
the origin of frame_a to the middle of rod 1, this might be defined as:
</p>
<pre>
    MultiBody.Joints.Assemblies.JointUSP jointUSR(rRod1_ia={1.2, 1, 0.2});
    MultiBody.Visualizers.FixedShape     shape(shapeType       = \"box\",
                                               lengthDirection = jointUSR.eRod1_ia,
                                               widthDirection  = jointUSR.e2_ia,
                                               length          = jointUSR.rod1Length/2,
                                               width           = jointUSR.rod1Length/10);
  <b>equation</b>
    <b>connect</b>(jointUSP.frame_ia, shape.frame_a);
</pre>
</html> "),
        Icon(
          Text(
            extent=[-127, -46; 133, -104],
            style(color=3),
            string="%name"),
          Ellipse(extent=[-100, -30; -40, 30], style(
              color=9,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[-93, -22; -48, 23], style(
              color=9,
              fillColor=7,
              fillPattern=1)),
          Rectangle(extent=[-70, 40; -39, -33], style(color=7, fillColor=7)),
          Line(points=[-70, 28; -70, -30], style(
              color=0,
              thickness=2,
              fillColor=7,
              fillPattern=1)),
          Ellipse(extent=[-89, -18; -48, 18], style(
              color=9,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[-84, -12; -53, 13], style(
              color=9,
              fillColor=7,
              fillPattern=1)),
          Polygon(points=[-81, -17; -92, -1; -83, 16; -57, 24; -81, -17], style(
              pattern=0,
              fillColor=7,
              fillPattern=1)),
          Line(points=[-70, 30; -70, -10], style(
              color=0,
              thickness=2,
              fillColor=7,
              fillPattern=1)),
          Line(points=[-61, 16; -79, -15], style(
              color=0,
              thickness=2,
              fillColor=7,
              fillPattern=1)),
          Line(points=[-50, 0; -50, 80; -80, 80; -80, 100], style(color=10,
                thickness=2)),
          Ellipse(extent=[-40, -30; 20, 30], style(
              color=8,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[-33, -22; 12, 23], style(color=8, fillColor=7)),
          Rectangle(extent=[-44, 31; -14, -30], style(
              color=7,
              fillColor=7,
              fillPattern=1)),
          Ellipse(extent=[-23, 10; -3, -10], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[19, 6; 61, -6], style(gradient=2, fillColor=8)),
          Rectangle(extent=[-50, 5; -21, -5], style(gradient=2, fillColor=8)),
          Rectangle(extent=[60, -30; 76, 30], style(
              color=8,
              gradient=2,
              fillColor=8)),
          Rectangle(extent=[85, -30; 100, 30], style(
              color=8,
              gradient=2,
              fillColor=8)),
          Rectangle(extent=[76, 10; 85, -10], style(
              color=0,
              gradient=0,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[60, 30; 76, -30], style(color=0)),
          Rectangle(extent=[85, 30; 100, -30], style(color=0)),
          Text(
            extent=[30, 124; 72, 93],
            style(color=10),
            string="ib"),
          Text(
            extent=[-143, 127; -103, 93],
            style(color=10),
            string="ia"),
          Line(points=[60, 30; 60, 80; 80, 80; 80, 100], style(color=10,
                thickness=2)),
          Text(
            extent=[-54, 125; -14, 91],
            style(color=10),
            string="im"),
          Line(points=[19, 6; 19, 80; 0, 80; 0, 100], style(color=10, thickness
                =2)),
          Line(points=[80, 80; 101, 80], style(color=10, thickness=2)),
          Line(points=[100, 40; 93, 40; 93, 30], style(color=10, thickness=2))),

        Diagram);

      MultiBody.Joints.Internal.RevoluteWithLengthConstraint revolute(
        animation=animation,
        lengthConstraint=rod1Length,
        n=n_b,
        phi_offset=phi_offset,
        phi_guess=phi_guess,
        cylinderDiameter=revoluteDiameter,
        cylinderLength=revoluteLength,
        cylinderColor=revoluteColor,
        axisTorqueBalance=false) annotation (extent=[75, -20; 35, 20]);
      MultiBody.Joints.UniversalSpherical rod1(
        animation=animation,
        showUniversalAxes=showUniversalAxes,
        rRod_ia=rRod1_ia,
        n1_a=n1_a,
        sphereDiameter=sphereDiameter,
        sphereColor=sphereColor,
        rodWidth=rod1Diameter,
        rodHeight=rod1Diameter,
        rodColor=rod1Color,
        cylinderLength=cylinderLength,
        cylinderDiameter=cylinderDiameter,
        cylinderColor=cylinderColor,
        kinematicConstraint=false) annotation (extent=[-92, -20; -52, 20]);
      MultiBody.Parts.FixedTranslation rod2(
        animation=animation,
        width=rod2Diameter,
        height=rod2Diameter,
        color=rod2Color,
        r=rRod2_ib) annotation (extent=[15, -20; -25, 20]);
      MultiBody.Sensors.RelativeSensor relativeSensor(animation=false)
        annotation (extent=[60, -70; 40, -90]);
      Modelica.Blocks.Sources.Constant position_b(k=rRod2_ib)
        annotation (extent=[-20, -50; 0, -30]);
    equation
      defineRoot(frame_ib.R);

      /* Compute the unknown force in the rod of the rod1 joint
     by a torque balance at the revolute joint:
       0 = revolute.frame_b.t + frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
           + cross(r_ib, -rod1.f_b_a1)
           + cross(r_ib, Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod1_ia))
     The condition is that the projection of the torque in the revolute
     joint along the axis of the revolute joint is equal to the driving
     axis torque in the flange:
       -revolute.tau = revolute.e*frame_b.t
     Therefore, we have
        tau = e*(frame_ib.t  + frame_im.t + cross(rRod2_ib, frame_im.f)
              + cross(rRod2_ib, -rod1.f_b_a1))
              + e*cross(rRod2_ib, Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod_a))
            = e*(frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
              + cross(rRod2_ib, -rod.f_b_a1))
              + rod1.f_rod*e*cross(rRod2_ib, Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     Solving this equation for f_rod results in
       rod1.f_rod = (-tau - e*(frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
                   + cross(rRod2_ib, -rod1.f_b_a1)))
                   / (cross(e,rRod2_ib)*Frames.resolve2(rod1.R_rel, rod1.eRod_a)))
     Additionally, a guard against division by zero is introduced
  */
      aux = cross(revolute.e, rRod2_ib)*Frames.resolveRelative(rod1.eRod_a,
        rod1.frame_a.R, rod1.frame_b.R);
      rod1.f_rod = (-revolute.tau - revolute.e*(frame_ib.t + frame_im.t + cross(
        rRod2_ib, frame_im.f) - cross(rRod2_ib, Frames.resolveRelative(rod1.
        f_b_a1, rod1.frame_a.R, rod1.frame_b.R))))/noEvent(if abs(aux) < 1.e-10
         then 1.e-10 else aux);

      // Measure power for test purposes
      if checkTotalPower then
        totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) +
          frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + frame_ia.f*
          Frames.resolve2(frame_ia.R, der(frame_ia.r_0)) + frame_ib.f*
          Frames.resolve2(frame_ib.R, der(frame_ib.r_0)) + frame_im.f*
          Frames.resolve2(frame_im.R, der(frame_im.r_0)) + frame_a.t*
          Frames.angularVelocity2(frame_a.R) + frame_b.t*
          Frames.angularVelocity2(frame_b.R) + frame_ia.t*
          Frames.angularVelocity2(frame_ia.R) + frame_ib.t*
          Frames.angularVelocity2(frame_ib.R) + frame_im.t*
          Frames.angularVelocity2(frame_im.R) + axis.tau*der(axis.phi) +
          bearing.tau*der(bearing.phi);
      else
        totalPower = 0;
      end if;

      connect(revolute.frame_b, rod2.frame_a) annotation (points=[33, 0; 17, 0],
           style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(rod2.frame_b, rod1.frame_b) annotation (points=[-27, 0; -50, 0],
          style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(revolute.frame_a, frame_b) annotation (points=[77, 0; 110, 0],
          style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(rod2.frame_a, frame_ib) annotation (points=[17, 0; 26, 0; 26, 70;
             80, 70; 80, 110], style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(rod1.frame_a, frame_a) annotation (points=[-94, 0; -110, 0],
          style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(relativeSensor.frame_b, frame_a) annotation (points=[39, -80; -96,
             -80; -96, 0; -110, 0], style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(relativeSensor.frame_a, frame_b) annotation (points=[61, -80; 96,
             -80; 96, 0; 110, 0], style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(relativeSensor.outPort, revolute.position_a) annotation (points=[
            50, -69; 50, -40; 90, -40; 90, -12; 79, -12], style(
          color=3,
          gradient=3,
          fillColor=8));
      connect(position_b.outPort, revolute.position_b) annotation (points=[1, -40;
             20, -40; 20, -12; 31, -12], style(
          color=3,
          gradient=3,
          fillColor=8));
      connect(rod2.frame_b, frame_im) annotation (points=[-27, 0; -40, 0; -40,
            80; 0, 80; 0, 110], style(color=0, thickness=2));
      connect(rod1.frame_ia, frame_ia) annotation (points=[-80, 22.1; -80, 110;
             -79, 110], style(color=0, thickness=2));
      connect(revolute.axis, axis) annotation (points=[55, 20; 55, 60; 90, 60;
            90, 80; 110, 80], style(color=0));
      connect(revolute.bearing, bearing)
        annotation (points=[67, 20; 67, 40; 110, 40], style(color=0));
    end JointUSR;

    model JointUSP
      "Universal - spherical - prismatic joint aggregation (no constraints, no potential states)"


      import SI = Modelica.SIunits;

      extends MultiBody.Interfaces.PartialTwoFrames;
      MultiBody.Interfaces.Frame_a frame_ia
        annotation (extent=[-64, 120; -94, 100], rotation=-270);
      MultiBody.Interfaces.Frame_b frame_ib
        annotation (extent=[65, 120; 95, 100], rotation=-90);
      MultiBody.Interfaces.Frame_b frame_im
        annotation (extent=[-15, 120; 15, 100], rotation=-90);
      Modelica.Mechanics.Translational.Interfaces.Flange_a axis
        annotation (extent=[100, 70; 120, 90]);
      Modelica.Mechanics.Translational.Interfaces.Flange_b bearing
        annotation (extent=[120, 30; 100, 50]);

      parameter Boolean animation=true "= true, if animation shall be enabled";
      parameter Boolean showUniversalAxes=true
        " = true, if universal joint shall be visualized with two cylinders, otherwise with a sphere (provided animation=true)";
      parameter MultiBody.Types.Axis n1_a={0,0,1}
        "Axis 1 of universal joint fixed and resolved in frame_a (axis 2 is orthogonal to axis 1 and to rod 1)"
        annotation (Evaluate=true);
      parameter MultiBody.Types.Axis n_b={-1,0,0}
        "Axis of prismatic joint fixed and resolved in frame_b"
        annotation (Evaluate=true);
      parameter SI.Position rRod1_ia[3]={1,0,0}
        "Vector from origin of frame_a to spherical joint, resolved in frame_ia"
        annotation (Evaluate=true);
      parameter SI.Position rRod2_ib[3]={-1,0,0}
        "Vector from origin of frame_ib to spherical joint, resolved in frame_ib (frame_ib is parallel to frame_b)";
      parameter SI.Position s_offset=0
        "Relative distance offset of prismatic joint (distance between the prismatic joint frames = s(t) + s_offset)";
      parameter SI.Position s_guess=0
        "Select the configuration such that at initial time |s(t0)-s_guess| is minimal";
      parameter SI.Diameter sphereDiameter=world.defaultJointLength
        "|Animation|if animation = true| Diameter of the spheres representing the universal and the spherical joint";
      parameter MultiBody.Types.Color sphereColor=Types.Defaults.JointColor
        "|Animation|if animation = true| Color of the spheres representing the universal and the spherical joint";
      parameter SI.Diameter rod1Diameter=sphereDiameter/Types.Defaults.
          JointRodDiameterFraction
        "|Animation|if animation = true| Diameter of rod 1 connecting the universal and the spherical joint";
      parameter MultiBody.Types.Color rod1Color=Types.Defaults.RodColor
        "|Animation|if animation = true| Color of rod 1 connecting the universal and the spherical joint";
      parameter SI.Diameter rod2Diameter=rod1Diameter
        "|Animation|if animation = true| Diameter of rod 2 connecting the prismatic and the spherical joint";
      parameter MultiBody.Types.Color rod2Color=rod1Color
        "|Animation|if animation = true| Color of rod 2 connecting the prismatic and the spherical joint";
      parameter MultiBody.Types.Axis boxWidthDirection={0,1,0}
        "|Animation|if animation = true| Vector in width direction of prismatic joint, resolved in frame_b"
        annotation (Evaluate=true);
      parameter SI.Distance boxWidth=world.defaultJointWidth
        "|Animation|if animation = true| Width of prismatic joint box";
      parameter SI.Distance boxHeight=boxWidth
        "|Animation|if animation = true| Height of prismatic joint box";
      parameter MultiBody.Types.Color boxColor=sphereColor
        "|Animation|if animation = true| Color of prismatic joint box";
      parameter SI.Distance cylinderLength=world.defaultJointLength
        "|Animation|if animation = true and showUniversalAxes| Length of cylinders representing the two universal joint axes";
      parameter SI.Distance cylinderDiameter=world.defaultJointWidth
        "|Animation|if animation = true and showUniversalAxes| Diameter of cylinders representing the two universal joint axes";
      parameter MultiBody.Types.Color cylinderColor=Types.Defaults.JointColor
        "|Animation|if animation = true and showUniversalAxes| Color of cylinders representing the two universal joint axes";

      parameter Boolean checkTotalPower=false
        "|Advanced|| = true, if total power flowing into this component shall be determined (must be zero)";
      final parameter Real eRod1_ia[3]=rod1.eRod_ia
        "Unit vector from origin of frame_a to origin of spherical joint, resolved in frame_ia";
      final parameter Real e2_ia[3]=rod1.e2_ia
        "Unit vector in direction of axis 2 of universal joint, resolved in frame_ia";
      final parameter SI.Distance rod1Length=rod1.rodLength
        "Length of rod 1 (= distance between universal and spherical joint";
      SI.Power totalPower
        "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";
      annotation (
        preferedView="info",
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.19,
          y=0.01,
          width=0.81,
          height=0.81),
        Documentation(info="<html>
<p>
This component consists of a <b>universal</b> joint at frame_a, a <b>prismatic</b>
joint at frame_b and a <b>spherical</b> joint which is connected via <b>rod1</b>
to the universal and via <b>rod2</b> to the prismatic joint, see the default
animation in the following figure (the axes vectors are not part of the
default animation):
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Joints/JointUSP.png\" ALT=\"model Joints.Assemblies.JointUSP\">
</p>
<p>
This joint aggregation has no mass and no inertia and
introduces neither constraints nor potential state variables.
It should be used in kinematic loops whenever possible since
the non-linear system of equations introduced by this joint aggregation
is solved <b>analytically</b> (i.e., a solution is always computed, if a
unique solution exists).
</p>
<p>
The universal joint is defined in the following way:
<p>
<ul>
<li> The rotation <b>axis</b> of revolute joint <b>1</b> is along parameter
     vector n1_a which is fixed in frame_a.<li>
<li> The rotation <b>axis</b> of revolute joint <b>2</b> is perpendicular to
     axis 1 and to the line connecting the universal and the spherical joint
     (= rod 1).
</ul>
<p>
The definition of axis 2 of the universal joint is performed according
to the most often occuring case. In a future release, axis 2 might
be explicitly definable via a parameter. However, the treatment is much more
complicated and the number of operations is considerably higher,
if axis 2 is not orthogonal to axis 1 and to the connecting rod.
</p>
<p>
Note, there is a <b>singularity</b> when axis 1 and the connecting rod are parallel
to each other. Therefore, if possible n1_a should be selected in such a way that it
is perpendicular to rRod1_ia in the initial configuration (i.e., the
distance to the singularity is as large as possible).
</p>
<p>
The rest of this joint aggregation is defined by the following parameters:
</p>
<ul>
<li> The position of the spherical joint with respect to the universal
     joint is defined by vector <b>rRod1_ia</b>. This vector is directed from
     frame_a to the spherical joint and is resolved in frame_ia
     (it is most simple to select frame_ia such that it is parallel to
     frame_a in the reference or initial configuration).</li>
<li> The position of the spherical joint with respect to the prismatic
     joint is defined by vector <b>rRod2_ib</b>. This vector is directed from
     the inner frame of the prismatic joint (frame_ib or prismatic.frame_a)
     to the spherical joint and is resolved in frame_ib (note, that frame_ib
     and frame_b are parallel to each other).</li>
<li> The axis of translation of the prismatic joint is defined by axis
     vector <b>n_b</b>. It is fixed and resolved in frame_b.</li>
<li> The two frames of the prismatic joint, i.e., frame_b and frame_ib,
     are parallel to each other.
     The distance between the origins of these two frames along axis n_b
     is equal to \"prismatic.s(t) + s_offset\", where \"prismatic.s(t)\" is
     a time varying variable and \"s_offset\" is a fixed, constant offset
     parameter.</li>
<li> When specifying this joint aggregation with the definitions above, <b>two</b>
     different <b>configurations</b> are possible. Via parameter <b>s_guess</b>
     a guess value for prismatic.s(t0) at the initial time t0 is given. The configuration
     is selected that is closest to s_guess (|prismatic.s - s_guess| is minimal).
</ul>
<p>
An additional <b>frame_ia</b> is present. It is <b>fixed</b> in the rod
connecting the universal and the spherical joint at the
origin of <b>frame_a</b>. The placement of frame_ia on the rod
is implicitly defined by the universal joint (frame_a and frame_ia coincide
when the angles of the two revolute joints of the universal joint are zero)
and by parameter vector <b>rRod1_ia</b>, the position vector
from the origin of frame_a to the spherical joint, resolved in frame_<b>ia</b>.
</p
<p>
An additional <b>frame_ib</b> is present. It is <b>fixed</b> in the rod
connecting the prismatic and the spherical joint at the side of the prismatic
joint that is connected to this rod (= rod2.frame_a = prismatic.frame_a).
It is always parallel to <b>frame_b</b>.
</p>
<p>
An additional <b>frame_im</b> is present. It is <b>fixed</b> in the rod
connecting the prismatic and the spherical joint at the side of the spherical
joint that is connected to this rod (= rod2.frame_b).
It is always parallel to <b>frame_b</b>.
</p>
<p>
The easiest way to define the parameters of this joint is by moving the
MultiBody system in a <b>reference configuration</b> where <b>all frames</b>
of all components are <b>parallel</b> to each other (alternatively,
at least frame_a and frame_ia of the JointUSP joint
should be parallel to each other when defining an instance of this
component).
</p>
<p>
In the public interface of the JointUSP joint, the following
(final) <b>parameters</b> are provided:
</p>
<pre>
  <b>parameter</b> Real rod1Length(unit=\"m\")  \"Length of rod 1\";
  <b>parameter</b> Real eRod1_ia[3] \"Unit vector along rod 1, resolved in frame_ia\";
  <b>parameter</b> Real e2_ia  [3]  \"Unit vector along axis 2, resolved in frame_ia\";
</pre>
<p>
This allows a more convenient definition of data which is related to rod 1.
For example, if a box shall be connected at frame_ia directing from
the origin of frame_a to the middle of rod 1, this might be defined as:
</p>
<pre>
    MultiBody.Joints.Assemblies.JointUSP jointUSP(rRod1_ia={1.2, 1, 0.2});
    MultiBody.Visualizers.FixedShape     shape(shapeType       = \"box\",
                                               lengthDirection = jointUSP.eRod1_ia,
                                               widthDirection  = jointUSP.e2_ia,
                                               length          = jointUSP.rod1Length/2,
                                               width           = jointUSP.rod1Length/10);
  <b>equation</b>
    <b>connect</b>(jointUSP.frame_ia, shape.frame_a);
</pre>
</html> "),
        Icon(
          Rectangle(extent=[50, 20; 80, -20], style(color=0, fillColor=8)),
          Rectangle(extent=[80, 30; 100, -30], style(color=0, fillColor=8)),
          Text(
            extent=[-131, -68; 129, -126],
            style(color=3),
            string="%name"),
          Ellipse(extent=[-100, -30; -40, 30], style(
              color=9,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[-93, -22; -48, 23], style(
              color=9,
              fillColor=7,
              fillPattern=1)),
          Rectangle(extent=[-70, 40; -39, -33], style(color=7, fillColor=7)),
          Line(points=[-70, 28; -70, -30], style(
              color=0,
              thickness=2,
              fillColor=7,
              fillPattern=1)),
          Ellipse(extent=[-89, -18; -48, 18], style(
              color=9,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[-84, -12; -53, 13], style(
              color=9,
              fillColor=7,
              fillPattern=1)),
          Polygon(points=[-81, -17; -92, -1; -83, 16; -57, 24; -81, -17], style(
              pattern=0,
              fillColor=7,
              fillPattern=1)),
          Line(points=[-70, 30; -70, -10], style(
              color=0,
              thickness=2,
              fillColor=7,
              fillPattern=1)),
          Line(points=[-61, 16; -79, -15], style(
              color=0,
              thickness=2,
              fillColor=7,
              fillPattern=1)),
          Line(points=[-50, 0; -50, 80; -80, 80; -80, 100], style(color=0,
                thickness=2)),
          Ellipse(extent=[-40, -30; 20, 30], style(
              color=8,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[-33, -22; 12, 23], style(color=8, fillColor=7)),
          Rectangle(extent=[-44, 31; -14, -30], style(
              color=7,
              fillColor=7,
              fillPattern=1)),
          Ellipse(extent=[-23, 10; -3, -10], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[19, 6; 50, -6], style(gradient=2, fillColor=8)),
          Rectangle(extent=[-50, 5; -21, -5], style(gradient=2, fillColor=8)),
          Text(
            extent=[25, 124; 67, 93],
            style(color=10),
            string="ib"),
          Text(
            extent=[-143, 127; -103, 93],
            style(color=10),
            string="ia"),
          Line(points=[50, 6; 50, 80; 80, 80; 80, 100], style(color=0,
                thickness=2)),
          Text(
            extent=[-54, 125; -14, 91],
            style(color=10),
            string="im"),
          Line(points=[19, 6; 19, 80; 0, 80; 0, 100], style(color=0, thickness=
                  2)),
          Rectangle(extent=[80, 24; 100, 30], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[50, 14; 80, 20], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Line(points=[100, 80; 79, 80], style(color=58)),
          Line(points=[99, 40; 90, 40; 90, 30], style(color=58))),
        Diagram(
          Line(points=[-78, 30; -50, 30], style(color=10, arrow=1)),
          Text(
            extent=[-76, 39; -49, 32],
            string="rRod1_ia",
            style(color=10, arrow=1)),
          Text(
            extent=[-27, 40; 0, 33],
            string="rRod2_ib",
            style(color=10)),
          Line(points=[3, 30; -43, 30], style(color=10, arrow=1))));

      MultiBody.Joints.Internal.PrismaticWithLengthConstraint prismatic(
        animation=animation,
        length=rod1.rodLength,
        n=n_b,
        s_offset=s_offset,
        s_guess=s_guess,
        boxWidthDirection=boxWidthDirection,
        boxWidth=boxWidth,
        boxHeight=boxHeight,
        boxColor=boxColor,
        axisForceBalance=false) annotation (extent=[76, -20; 36, 20]);
      MultiBody.Joints.UniversalSpherical rod1(
        animation=animation,
        showUniversalAxes=showUniversalAxes,
        rRod_ia=rRod1_ia,
        n1_a=n1_a,
        sphereDiameter=sphereDiameter,
        sphereColor=sphereColor,
        rodWidth=rod1Diameter,
        rodHeight=rod1Diameter,
        rodColor=rod1Color,
        cylinderLength=cylinderLength,
        cylinderDiameter=cylinderDiameter,
        cylinderColor=cylinderColor,
        kinematicConstraint=false) annotation (extent=[-92, -20; -52, 20]);
      MultiBody.Parts.FixedTranslation rod2(
        animation=animation,
        r=rRod2_ib,
        width=rod2Diameter,
        height=rod2Diameter,
        color=rod2Color) annotation (extent=[0, 20; -40, -20]);
      MultiBody.Sensors.RelativeSensor relativeSensor(animation=false)
        annotation (extent=[50, -70; 30, -90]);
      Modelica.Blocks.Sources.Constant position_b(k=rRod2_ib)
        annotation (extent=[-20, -60; 0, -40], rotation=0);
    protected
      SI.Position aux
        "Denominator used to compute force in rod connecting universal and spherical joint";
    equation
      /* Compute the unknown force in rod1 connecting the universal and
     the spherical joint by a force balance at the prismatic joint
        0 = -prismatic.frame_b.f + frame_ib.f + frame_im.f - rod1.frame_b.f
     The force at rod1.frame_b is split into two parts:
        rod1.frame_b.f = Frames.resolve2(rod1.R_rel, rod1.f_b_a1 - rod1.f_rod*rod1.eRod_a)
     where rod1.f_rod is the unknown force in rod1.
     The condition is that the projection of the force in the prismatic
     joint along the axis of its translation axis is equal to the driving
     axis force in the flange:
       -prismatic.f = prismatic.e*prismatic.frame_b.f
     Therefore, we have with e=prismatic.e and f=prismatic.f
       -f = e*(frame_ib.f + frame_im.f
               - Frames.resolve2(rod1.R_rel, rod1.f_b_a1 - rod1.f_rod*rod1.eRod_a))
          = e*(frame_ib.f + frame_im.f - Frames.resolve2(rod1.R_rel, rod1.f_b_a1)
              + rod1.f_rod*Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     Solving this equation for f_rod results in
       rod1.f_rod = -(f+e*(frame_ib.f + frame_im.f - Frames.resolve2(rod1.R_rel, rod1.f_b_a1))
                   /(e*Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     Additionally, a guard against division by zero is introduced
  */
      defineRoot(frame_ib.R);
      aux = prismatic.e*Frames.resolveRelative(rod1.eRod_a, rod1.frame_a.R,
        rod1.frame_b.R);
      rod1.f_rod = (-prismatic.f - prismatic.e*(frame_ib.f + frame_im.f -
        Frames.resolveRelative(rod1.f_b_a1, rod1.frame_a.R, rod1.frame_b.R)))/
        noEvent(if abs(aux) < 1.e-10 then 1.e-10 else aux);
      // Measure power for test purposes
      if checkTotalPower then
        totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) +
          frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + frame_ia.f*
          Frames.resolve2(frame_ia.R, der(frame_ia.r_0)) + frame_ib.f*
          Frames.resolve2(frame_ib.R, der(frame_ib.r_0)) + frame_im.f*
          Frames.resolve2(frame_im.R, der(frame_im.r_0)) + frame_a.t*
          Frames.angularVelocity2(frame_a.R) + frame_b.t*
          Frames.angularVelocity2(frame_b.R) + frame_ia.t*
          Frames.angularVelocity2(frame_ia.R) + frame_ib.t*
          Frames.angularVelocity2(frame_ib.R) + frame_im.t*
          Frames.angularVelocity2(frame_im.R) + axis.f*der(axis.s) + bearing.f*
          der(bearing.s);
      else
        totalPower = 0;
      end if;

      connect(prismatic.frame_b, rod2.frame_a) annotation (points=[34, 0; 2, 0],
           style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(rod2.frame_b, rod1.frame_b) annotation (points=[-42, 0; -50, 0],
          style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(prismatic.frame_a, frame_b) annotation (points=[78, 0; 110, 0],
          style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(rod2.frame_a, frame_ib) annotation (points=[2, 0; 7, 0; 7, 70; 80,
             70; 80, 110], style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(rod1.frame_a, frame_a) annotation (points=[-94, 0; -110, 0],
          style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(relativeSensor.frame_b, frame_a) annotation (points=[29, -80; -97,
             -80; -97, 0; -110, 0], style(
          color=0,
          pattern=3,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(relativeSensor.frame_a, frame_b) annotation (points=[51, -80; 95,
             -80; 95, 0; 110, 0], style(
          color=0,
          pattern=3,
          gradient=3,
          fillColor=8));
      connect(rod2.frame_b, frame_im) annotation (points=[-42, 0; -46, 0; -46,
            80; 0, 80; 0, 110], style(color=0, thickness=2));
      connect(rod1.frame_ia, frame_ia) annotation (points=[-80, 22.1; -80, 110;
             -79, 110], style(color=0, thickness=2));
      connect(position_b.outPort, prismatic.position_b) annotation (points=[1,
            -50; 10, -50; 10, -12; 32, -12], style(
          color=3,
          fillColor=8,
          fillPattern=1));
      connect(relativeSensor.outPort, prismatic.position_a) annotation (points=
            [40, -69; 40, -40; 90, -40; 90, -12; 80, -12], style(
          color=3,
          fillColor=8,
          fillPattern=1));
      connect(prismatic.axis, axis) annotation (points=[40, 14; 40, 56; 90, 56;
             90, 80; 110, 80], style(color=58));
      connect(prismatic.bearing, bearing)
        annotation (points=[64, 14; 64, 40; 110, 40], style(color=58));
    end JointUSP;

    model JointSSR
      "Spherical - spherical - revolute joint aggregation with mass (no constraints, no potential states)"


      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;

      extends MultiBody.Interfaces.PartialTwoFrames;
      MultiBody.Interfaces.Frame_b frame_ib
        annotation (extent=[45, 120; 75, 100], rotation=-90);
      MultiBody.Interfaces.Frame_b frame_im
        annotation (extent=[-15, 120; 15, 100], rotation=-90);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis
        annotation (extent=[120, 90; 100, 70]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_b bearing
        annotation (extent=[100, 50; 120, 30]);

      parameter Boolean animation=true "= true, if animation shall be enabled";
      parameter Boolean showMass=true
        "= true, if point mass on rod 1 shall be shown (provided animation = true and rod1Mass > 0)";
      parameter SI.Length rod1Length(min=Modelica.Constants.eps) = 1
        "Distance between the origins of the two spherical joints ";
      parameter SI.Mass rod1Mass=0
        "Mass of rod 1 (= point mass located in middle of rod connecting the two spherical joints)";
      parameter MultiBody.Types.Axis n_b={0,0,1}
        "Axis of revolute joint fixed and resolved in frame_b";
      parameter SI.Position rRod2_ib[3]={1,0,0}
        "Vector from origin of frame_ib to spherical joint in the middle, resolved in frame_ib";
      parameter Cv.NonSIunits.Angle_deg phi_offset=0
        "Relative angle offset of revolute joint (angle = phi(t) + from_deg(phi_offset))";
      parameter Cv.NonSIunits.Angle_deg phi_guess=0
        "Select the configuration such that at initial time |phi(t0) - from_deg(phi_guess)| is minimal";
      parameter SI.Diameter sphereDiameter=world.defaultJointLength
        "|Animation|if animation = true| Diameter of the spheres representing the two spherical joints";
      parameter MultiBody.Types.Color sphereColor=MultiBody.Types.Defaults.
          JointColor
        "|Animation|if animation = true| Color of the spheres representing the two spherical joints";
      parameter SI.Diameter rod1Diameter=sphereDiameter/Types.Defaults.
          JointRodDiameterFraction
        "|Animation|if animation = true| Diameter of rod 1 connecting the two spherical joints";
      parameter MultiBody.Types.Color rod1Color=MultiBody.Types.Defaults.
          RodColor
        "|Animation|if animation = true| Color of rod 1 connecting the two spherical joint";

      parameter SI.Diameter rod2Diameter=rod1Diameter
        "|Animation|if animation = true| Diameter of rod 2 connecting the revolute joint and spherical joint 2";
      parameter MultiBody.Types.Color rod2Color=rod1Color
        "|Animation|if animation = true| Color of rod 2 connecting the revolute joint and spherical joint 2";
      parameter SI.Diameter revoluteDiameter=world.defaultJointWidth
        "|Animation|if animation = true| Diameter of cylinder representing the revolute joint";
      parameter SI.Distance revoluteLength=world.defaultJointLength
        "|Animation|if animation = true| Length of cylinder representing the revolute joint";
      parameter MultiBody.Types.Color revoluteColor=MultiBody.Types.Defaults.
          JointColor
        "|Animation|if animation = true| Color of cylinder representing the revolute joint";
      parameter Boolean checkTotalPower=false
        "|Advanced|| = true, if total power flowing into this component shall be determined (must be zero)";
      SI.Position aux
        "Denominator used to compute force in rod connecting universal and spherical joint";
      SI.Power totalPower
        "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";
      annotation (
        preferedView="info",
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.19,
          y=0.01,
          width=0.81,
          height=0.81),
        Documentation(info="<html>
<p>
This component consists of a <b>spherical</b> joint 1 at frame_a, a <b>revolute</b>
joint at frame_b and a <b>spherical</b> joint 2 which is connected via rod 1
to the spherical joint 1 and via rod 2 to the revolute joint, see the default
animation in the following figure (the axes vectors are not part of the
default animation):
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Joints/JointSSR.png\" ALT=\"model Joints.Assemblies.JointSSR\">
</p>
<p>
Besides an optional point mass in the middle of rod 1,
this joint aggregation has no mass and no inertia,
and introduces neither constraints nor potential state variables.
It should be used in kinematic loops whenever possible since
the non-linear system of equations introduced by this joint aggregation
is solved <b>analytically</b> (i.e., a solution is always computed, if a
unique solution exists).
</p>
<p>
An additional <b>frame_ib</b> is present. It is <b>fixed</b> in rod 2
connecting the revolute and the spherical joint at the side of the revolute
joint that is connected to this rod (= rod2.frame_a = revolute.frame_a).
</p>
<p>
An additional <b>frame_im</b> is present. It is <b>fixed</b> in rod 2
connecting the revolute and the spherical joint at the side of spherical
joint 2 that is connected to this rod (= rod2.frame_b).
It is always parallel to <b>frame_ib</b>.
</p>
<p>
The easiest way to define the parameters of this joint is by moving the
MultiBody system in a <b>reference configuration</b> where <b>all frames</b>
of all components are <b>parallel</b> to each other (alternatively,
at least frame_b and frame_ib of the JointSSR joint
should be parallel to each other when defining an instance of this
component).
</p>
</html> "),
        Icon(
          Text(
            extent=[-127, -46; 133, -104],
            style(color=3),
            string="%name"),
          Ellipse(extent=[-100, -30; -40, 30], style(
              color=9,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[-93, -22; -48, 23], style(
              color=9,
              fillColor=7,
              fillPattern=1)),
          Rectangle(extent=[-63, 33; -39, -33], style(color=7, fillColor=7)),
          Ellipse(extent=[-40, -30; 20, 30], style(
              color=8,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[-33, -22; 12, 23], style(color=8, fillColor=7)),
          Rectangle(extent=[-44, 31; -19, -30], style(
              color=7,
              fillColor=7,
              fillPattern=1)),
          Ellipse(extent=[-23, 10; -3, -10], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[19, 6; 61, -6], style(gradient=2, fillColor=8)),
          Rectangle(extent=[60, -30; 76, 30], style(
              color=8,
              gradient=2,
              fillColor=8)),
          Rectangle(extent=[85, -30; 100, 30], style(
              color=8,
              gradient=2,
              fillColor=8)),
          Rectangle(extent=[76, 10; 85, -10], style(
              color=0,
              gradient=0,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[60, 30; 76, -30], style(color=0)),
          Rectangle(extent=[85, 30; 100, -30], style(color=0)),
          Line(points=[60, 30; 60, 80; 60, 80; 60, 100], style(color=0,
                thickness=2)),
          Text(
            extent=[81, 122; 123, 91],
            style(color=10),
            string="ib"),
          Ellipse(extent=[-80, 11; -60, -9], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[-62, 6; -21, -5], style(gradient=2, fillColor=8)),
          Line(points=[60, 80; 100, 80], style(color=0)),
          Line(points=[93, 31; 93, 40; 100, 40], style(color=0)),
          Line(points=[20, 6; 20, 80; 1, 80; 1, 100], style(color=0, thickness=
                  2)),
          Text(
            extent=[-59, 127; -19, 93],
            style(color=10),
            string="im")),
        Diagram);

      MultiBody.Joints.Internal.RevoluteWithLengthConstraint revolute(
        animation=animation,
        lengthConstraint=rod1Length,
        n=n_b,
        phi_offset=phi_offset,
        phi_guess=phi_guess,
        cylinderDiameter=revoluteDiameter,
        cylinderLength=revoluteLength,
        cylinderColor=revoluteColor,
        axisTorqueBalance=false) annotation (extent=[75, -20; 35, 20]);
      MultiBody.Joints.SphericalSpherical rod1(
        animation=animation,
        showMass=showMass,
        m=rod1Mass,
        rodLength=rod1Length,
        rodDiameter=rod1Diameter,
        sphereDiameter=sphereDiameter,
        rodColor=rod1Color,
        kinematicConstraint=false,
        sphereColor=sphereColor) annotation (extent=[-89, -20; -49, 20]);
      MultiBody.Parts.FixedTranslation rod2(
        animation=animation,
        width=rod2Diameter,
        height=rod2Diameter,
        color=rod2Color,
        r=rRod2_ib) annotation (extent=[15, -20; -25, 20]);
      MultiBody.Sensors.RelativeSensor relativeSensor(animation=false)
        annotation (extent=[60, -70; 40, -90]);
      Modelica.Blocks.Sources.Constant position_b(k=rRod2_ib)
        annotation (extent=[-20, -50; 0, -30]);
    equation
      defineRoot(frame_ib.R);
      /* Compute the unknown force in the rod of the rod1 joint
     by a torque balance at the revolute joint:
       0 = frame_b.t + frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
           + cross(rRod2_ib, -rod1.f_b_a1)
           + cross(rRod2_ib, Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod_a))
     The condition is that the projection of the torque in the revolute
     joint along the axis of the revolute joint is equal to the driving
     axis torque in the flange:
       -revolute.tau = revolute.e*frame_b.t
     Therefore, we have with e=revolute.e and tau=revolute.tau
        tau = e*(frame_ib.t  + frame_im.t + cross(rRod2_ib, frame_im.f)
              + cross(rRod2_ib, -rod1.f_b_a1))
              + e*cross(rRod2_ib, Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod_a))
            = e*(frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
              + cross(rRod2_ib, -rod.f_b_a1))
              + rod1.f_rod*e*cross(rRod2_ib, Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     Solving this equation for f_rod results in
       rod1.f_rod = (tau - e*(frame_ib.t + frame_im.t + cross(rRod2_ib, frame_im.f)
                   + cross(rRod2_ib, -rod1.f_b_a1)))
                   / (cross(e,rRod2_ib)*Frames.resolve2(rod1.R_rel, rod1.eRod_a)))
     Additionally, a guard against division by zero is introduced
  */

      aux = cross(revolute.e, rRod2_ib)*Frames.resolveRelative(rod1.eRod_a,
        rod1.frame_a.R, rod1.frame_b.R);
      rod1.f_rod = (-revolute.tau - revolute.e*(frame_ib.t + frame_im.t + cross(
        rRod2_ib, frame_im.f) - cross(rRod2_ib, Frames.resolveRelative(rod1.
        f_b_a1, rod1.frame_a.R, rod1.frame_b.R))))/noEvent(if abs(aux) < 1.e-10
         then 1.e-10 else aux);

      // Measure power for test purposes
      if checkTotalPower then
        totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) +
          frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + frame_ib.f*
          Frames.resolve2(frame_ib.R, der(frame_ib.r_0)) + frame_im.f*
          Frames.resolve2(frame_im.R, der(frame_im.r_0)) + frame_a.t*
          Frames.angularVelocity2(frame_a.R) + frame_b.t*
          Frames.angularVelocity2(frame_b.R) + frame_ib.t*
          Frames.angularVelocity2(frame_ib.R) + frame_im.t*
          Frames.angularVelocity2(frame_im.R) + axis.tau*der(axis.phi) +
          bearing.tau*der(bearing.phi) + (-rod1Mass)*(der(rod1.v_CM_0) -
          world.gravityAcceleration(rod1.r_CM_0))*rod1.v_CM_0;
      else
        totalPower = 0;
      end if;

      connect(revolute.frame_b, rod2.frame_a) annotation (points=[33, 0; 17, 0],
           style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(rod2.frame_b, rod1.frame_b) annotation (points=[-27, 0; -47, 0],
          style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(revolute.frame_a, frame_b) annotation (points=[77, 0; 110, 0],
          style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(rod2.frame_a, frame_ib) annotation (points=[17, 0; 26, 0; 26, 70;
             60, 70; 60, 110], style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(rod1.frame_a, frame_a) annotation (points=[-91, 0; -110, 0],
          style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(relativeSensor.frame_b, frame_a) annotation (points=[39, -80; -95,
             -80; -95, 0; -110, 0], style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(relativeSensor.frame_a, frame_b) annotation (points=[61, -80; 96,
             -80; 96, 0; 110, 0], style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(relativeSensor.outPort, revolute.position_a) annotation (points=[
            50, -69; 50, -40; 90, -40; 90, -12; 79, -12], style(
          color=3,
          gradient=3,
          fillColor=8));
      connect(position_b.outPort, revolute.position_b) annotation (points=[1, -40;
             20, -40; 20, -12; 31, -12], style(
          color=3,
          gradient=3,
          fillColor=8));
      connect(revolute.axis, axis) annotation (points=[55, 20; 55, 60; 80, 60;
            80, 80; 110, 80], style(color=0));
      connect(revolute.bearing, bearing)
        annotation (points=[67, 20; 67, 40; 110, 40], style(color=0));
      connect(rod2.frame_b, frame_im) annotation (points=[-27, 0; -35, 0; -35,
            60; 0, 60; 0, 110], style(color=0, thickness=2));
    end JointSSR;

    model JointSSP
      "Spherical - spherical - prismatic joint aggregation with mass (no constraints, no potential states)"


      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;

      extends MultiBody.Interfaces.PartialTwoFrames;
      MultiBody.Interfaces.Frame_b frame_ib
        annotation (extent=[65, 120; 95, 100], rotation=-90);
      MultiBody.Interfaces.Frame_b frame_im
        annotation (extent=[-15, 120; 15, 100], rotation=-90);
      Modelica.Mechanics.Translational.Interfaces.Flange_a axis
        annotation (extent=[120, 90; 100, 70]);
      Modelica.Mechanics.Translational.Interfaces.Flange_b bearing
        annotation (extent=[100, 50; 120, 30]);

      parameter Boolean animation=true "= true, if animation shall be enabled";
      parameter Boolean showMass=true
        "= true, if point mass on rod 1 shall be shown (provided animation = true and rod1Mass > 0)";
      parameter SI.Length rod1Length(min=Modelica.Constants.eps) = 1
        "Distance between the origins of the two spherical joints ";
      parameter SI.Mass rod1Mass=0
        "Mass of rod 1 (= point mass located in middle of rod connecting the two spherical joints)";
      parameter MultiBody.Types.Axis n_b={0,0,1}
        "Axis of prismatic joint fixed and resolved in frame_b";
      parameter SI.Position rRod2_ib[3]={1,0,0}
        "Vector from origin of frame_ib to spherical joint in the middle, resolved in frame_ib";
      parameter SI.Position s_offset=0
        "Relative distance offset of prismatic joint (distance between frame_b and frame_ib = s(t) + s_offset)";
      parameter SI.Position s_guess=0
        "Select the configuration such that at initial time |s(t0)-s_guess| is minimal";

      parameter SI.Diameter sphereDiameter=world.defaultJointLength
        "|Animation|if animation = true| Diameter of the spheres representing the two spherical joints";
      parameter MultiBody.Types.Color sphereColor=MultiBody.Types.Defaults.
          JointColor
        "|Animation|if animation = true| Color of the spheres representing the two spherical joints";
      parameter SI.Diameter rod1Diameter=sphereDiameter/Types.Defaults.
          JointRodDiameterFraction
        "|Animation|if animation = true| Diameter of rod 1 connecting the two spherical joints";
      parameter MultiBody.Types.Color rod1Color=MultiBody.Types.Defaults.
          RodColor
        "|Animation|if animation = true| Color of rod 1 connecting the two spherical joint";

      parameter SI.Diameter rod2Diameter=rod1Diameter
        "|Animation|if animation = true| Diameter of rod 2 connecting the revolute joint and spherical joint 2";
      parameter MultiBody.Types.Color rod2Color=rod1Color
        "|Animation|if animation = true| Color of rod 2 connecting the revolute joint and spherical joint 2";

      parameter MultiBody.Types.Axis boxWidthDirection={0,1,0}
        "|Animation|if animation = true| Vector in width direction of prismatic joint box, resolved in frame_b"
        annotation (Evaluate=true);
      parameter SI.Distance boxWidth=world.defaultJointWidth
        "|Animation|if animation = true| Width of prismatic joint box";
      parameter SI.Distance boxHeight=boxWidth
        "|Animation|if animation = true| Height of prismatic joint box";
      parameter MultiBody.Types.Color boxColor=Types.Defaults.JointColor
        "|Animation|if animation = true| Color of prismatic joint box";
      parameter Boolean checkTotalPower=false
        "|Advanced|| = true, if total power flowing into this component shall be determined (must be zero)";
      SI.Position aux
        "Denominator used to compute force in rod connecting universal and spherical joint";
      SI.Power totalPower
        "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";
      annotation (
        preferedView="info",
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.19,
          y=0.01,
          width=0.81,
          height=0.81),
        Documentation(info="<html>
<p>
This component consists of a <b>spherical</b> joint 1 at frame_a, a <b>prismatic</b>
joint at frame_b and a <b>spherical</b> joint 2 which is connected via rod 1
to the spherical joint 1 and via rod 2 to the prismatic joint, see the default
animation in the following figure (the axes vectors are not part of the
default animation):
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Joints/JointSSP.png\" ALT=\"model Joints.Assemblies.JointSSP\">
</p>
<p>
Besides an optional point mass in the middle of rod 1,
this joint aggregation has no mass and no inertia,
and introduces neither constraints nor potential state variables.
It should be used in kinematic loops whenever possible since
the non-linear system of equations introduced by this joint aggregation
is solved <b>analytically</b> (i.e., a solution is always computed, if a
unique solution exists).
</p>
<p>
An additional <b>frame_ib</b> is present. It is <b>fixed</b> in rod 2
connecting the prismatic and the spherical joint at the side of the prismatic
joint that is connected to this rod (= rod2.frame_a = prismatic.frame_a).
</p>
<p>
An additional <b>frame_im</b> is present. It is <b>fixed</b> in rod 2
connecting the prismatic and the spherical joint at the side of spherical
joint 2 that is connected to this rod (= rod2.frame_b).
It is always parallel to <b>frame_ib</b>.
</p>
<p>
The easiest way to define the parameters of this joint is by moving the
MultiBody system in a <b>reference configuration</b> where <b>all frames</b>
of all components are <b>parallel</b> to each other (alternatively,
at least frame_b and frame_ib of the JointSSP joint
should be parallel to each other when defining an instance of this
component).
</p>
</html> "),
        Icon(
          Text(
            extent=[-127, -46; 133, -104],
            style(color=3),
            string="%name"),
          Ellipse(extent=[-100, -30; -40, 30], style(
              color=9,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[-93, -22; -48, 23], style(
              color=9,
              fillColor=7,
              fillPattern=1)),
          Rectangle(extent=[-63, 33; -39, -33], style(color=7, fillColor=7)),
          Ellipse(extent=[-40, -30; 20, 30], style(
              color=8,
              gradient=3,
              fillColor=8)),
          Ellipse(extent=[-33, -22; 12, 23], style(color=8, fillColor=7)),
          Rectangle(extent=[-44, 31; -19, -30], style(
              color=7,
              fillColor=7,
              fillPattern=1)),
          Ellipse(extent=[-23, 10; -3, -10], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[19, 6; 61, -6], style(gradient=2, fillColor=8)),
          Text(
            extent=[95, 124; 137, 93],
            style(color=10),
            string="ib"),
          Ellipse(extent=[-80, 11; -60, -9], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[-62, 6; -21, -5], style(gradient=2, fillColor=8)),
          Line(points=[20, 6; 20, 80; 1, 80; 1, 100], style(color=0, thickness=
                  2)),
          Text(
            extent=[-59, 127; -19, 93],
            style(color=10),
            string="im"),
          Rectangle(extent=[50, 20; 80, -20], style(color=0, fillColor=8)),
          Rectangle(extent=[80, 30; 100, -30], style(color=0, fillColor=8)),
          Rectangle(extent=[50, 14; 80, 20], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[80, 24; 100, 30], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Line(points=[50, 6; 50, 80; 80, 80; 80, 100], style(color=0,
                thickness=2)),
          Line(points=[101, 80; 80, 80], style(color=58)),
          Line(points=[99, 40; 90, 40; 90, 30], style(color=58))),
        Diagram);

      MultiBody.Joints.Internal.PrismaticWithLengthConstraint prismatic(
        animation=animation,
        length=rod1Length,
        n=n_b,
        s_offset=s_offset,
        s_guess=s_guess,
        axisForceBalance=false,
        boxWidthDirection=boxWidthDirection,
        boxWidth=boxWidth,
        boxHeight=boxHeight,
        boxColor=boxColor) annotation (extent=[75, -20; 35, 20]);
      MultiBody.Joints.SphericalSpherical rod1(
        animation=animation,
        showMass=showMass,
        m=rod1Mass,
        rodLength=rod1Length,
        rodDiameter=rod1Diameter,
        sphereDiameter=sphereDiameter,
        rodColor=rod1Color,
        kinematicConstraint=false,
        sphereColor=sphereColor) annotation (extent=[-89, -20; -49, 20]);
      MultiBody.Parts.FixedTranslation rod2(
        animation=animation,
        width=rod2Diameter,
        height=rod2Diameter,
        color=rod2Color,
        r=rRod2_ib) annotation (extent=[15, -20; -25, 20]);
      MultiBody.Sensors.RelativeSensor relativeSensor(animation=false)
        annotation (extent=[60, -70; 40, -90]);
      Modelica.Blocks.Sources.Constant position_b(k=rRod2_ib)
        annotation (extent=[-20, -50; 0, -30]);
    equation
      defineRoot(frame_ib.R);
      /* Compute the unknown force in the rod of the rod1 joint
     by a force balance:
       0 = frame_b.f + frame_ib.f + frame_im.f +
           Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod_a)
     The condition is that the projection of the force in the prismatic
     joint along the axis of the prismatic joint is equal to the driving
     axis force in the flange:
       -prismatic.f = prismatic.e*frame_b.f
     Therefore, we have with e=prismatic.e and f=prismatic.f
        f = e*(frame_ib.f + frame_im.f +
               Frames.resolve2(rod1.R_rel, rod1.f_rod*rod1.eRod_a))
          = e*(frame_ib.f + frame_im.f +
               rod1.f_rod*Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     Solving this equation for f_rod results in
       rod1.f_rod = (f - e*(frame_ib.f + frame_im.f))
                    / (e*Frames.resolve2(rod1.R_rel, rod1.eRod_a))
     Additionally, a guard against division by zero is introduced
  */
      aux = prismatic.e*Frames.resolveRelative(rod1.eRod_a, rod1.frame_a.R,
        rod1.frame_b.R);
      rod1.f_rod = (-prismatic.f - prismatic.e*(frame_ib.f + frame_im.f))/
        noEvent(if abs(aux) < 1.e-10 then 1.e-10 else aux);

      // Measure power for test purposes
      if checkTotalPower then
        totalPower = frame_a.f*Frames.resolve2(frame_a.R, der(frame_a.r_0)) +
          frame_b.f*Frames.resolve2(frame_b.R, der(frame_b.r_0)) + frame_ib.f*
          Frames.resolve2(frame_ib.R, der(frame_ib.r_0)) + frame_im.f*
          Frames.resolve2(frame_im.R, der(frame_im.r_0)) + frame_a.t*
          Frames.angularVelocity2(frame_a.R) + frame_b.t*
          Frames.angularVelocity2(frame_b.R) + frame_ib.t*
          Frames.angularVelocity2(frame_ib.R) + frame_im.t*
          Frames.angularVelocity2(frame_im.R) + axis.f*der(axis.s) + bearing.f*
          der(bearing.s) + (-rod1Mass)*(der(rod1.v_CM_0) -
          world.gravityAcceleration(rod1.r_CM_0))*rod1.v_CM_0;
      else
        totalPower = 0;
      end if;

      connect(prismatic.frame_b, rod2.frame_a) annotation (points=[33, 0; 17, 0],
           style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(rod2.frame_b, rod1.frame_b) annotation (points=[-27, 0; -47, 0],
          style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(prismatic.frame_a, frame_b) annotation (points=[77, 0; 110, 0],
          style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(rod2.frame_a, frame_ib) annotation (points=[17, 0; 26, 0; 26, 70;
             80, 70; 80, 110], style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(rod1.frame_a, frame_a) annotation (points=[-91, 0; -110, 0],
          style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(relativeSensor.frame_b, frame_a) annotation (points=[39, -80; -95,
             -80; -95, 0; -110, 0], style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(relativeSensor.frame_a, frame_b) annotation (points=[61, -80; 96,
             -80; 96, 0; 110, 0], style(
          color=0,
          thickness=2,
          gradient=3,
          fillColor=8));
      connect(relativeSensor.outPort, prismatic.position_a) annotation (points=
            [50, -69; 50, -40; 90, -40; 90, -12; 79, -12], style(
          color=3,
          gradient=3,
          fillColor=8));
      connect(position_b.outPort, prismatic.position_b) annotation (points=[1,
            -40; 20, -40; 20, -12; 31, -12], style(
          color=3,
          gradient=3,
          fillColor=8));
      connect(prismatic.axis, axis) annotation (points=[39, 14; 39, 60; 80, 60;
             80, 80; 110, 80], style(color=0));
      connect(prismatic.bearing, bearing)
        annotation (points=[63, 14; 63, 40; 110, 40], style(color=0));
      connect(rod2.frame_b, frame_im) annotation (points=[-27, 0; -35, 0; -35,
            60; 0, 60; 0, 110], style(color=0, thickness=2));
    end JointSSP;

    model JointRRR
      "Planar revolute - revolute - revolute joint aggregation (no constraints, no potential states)"


      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;

      extends MultiBody.Interfaces.PartialTwoFrames;

      MultiBody.Interfaces.Frame_a frame_ia
        annotation (extent=[-95, 100; -65, 120], rotation=-90);
      MultiBody.Interfaces.Frame_b frame_im
        annotation (extent=[-16, 120; 14, 100], rotation=-90);
      MultiBody.Interfaces.Frame_b frame_ib
        annotation (extent=[65, 120; 95, 100], rotation=-90);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis
        annotation (extent=[120, 90; 100, 70]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_b bearing
        annotation (extent=[100, 50; 120, 30]);

      parameter Boolean animation=true "= true, if animation shall be enabled";
      parameter MultiBody.Types.Axis n_a={0,0,1}
        "Axes of revolute joints resolved in frame_a (all axes are parallel to each other)"
        annotation (Evaluate=true);
      final parameter Real n_b[3](fixed=false) = {0,0,1}
        "Axis of revolute joint fixed and resolved in frame_b"
        annotation (Evaluate=true);
      parameter SI.Position rRod1_ia[3]={1,0,0}
        "Vector from origin of frame_a to revolute joint in the middle, resolved in frame_ia"
        annotation (Evaluate=true);
      parameter SI.Position rRod2_ib[3]={-1,0,0}
        "Vector from origin of frame_ib to revolute joint in the middle, resolved in frame_ib";
      parameter Cv.NonSIunits.Angle_deg phi_offset=0
        "Relative angle offset of revolute joint at frame_b (angle = phi(t) + from_deg(phi_offset))";
      parameter Cv.NonSIunits.Angle_deg phi_guess=0
        "Select the configuration such that at initial time |phi(t0) - from_deg(phi_guess)| is minimal";
      parameter SI.Distance cylinderLength=world.defaultJointLength
        "|Animation|if animation = true| Length of cylinders representing the revolute joints";
      parameter SI.Distance cylinderDiameter=world.defaultJointWidth
        "|Animation|if animation = true| Diameter of cylinders representing the revolute joints";
      parameter MultiBody.Types.Color cylinderColor=MultiBody.Types.Defaults.
          JointColor
        "|Animation|if animation = true| Color of cylinders representing the revolute joints";
      parameter SI.Diameter rodDiameter=1.1*cylinderDiameter
        "|Animation|if animation = true| Diameter of the two rods connecting the revolute joints";
      parameter MultiBody.Types.Color rodColor=MultiBody.Types.Defaults.
          RodColor
        "|Animation|if animation = true| Color of the two rods connecting the revolute joint";
      parameter Boolean checkTotalPower=false
        "|Advanced|| = true, if total power flowing into this component shall be determined (must be zero)";
      final parameter Real e_a[3]=Frames.normalize(n_a)
        "Unit vector along axes of rotations, resolved in frame_a";
      final parameter Real e_ia[3]=jointUSR.e2_ia
        "Unit vector along axes of rotations, resolved in frame_ia";
      final parameter Real e_b[3]=jointUSR.revolute.e
        "Unit vector along axes of rotations, resolved in frame_b, frame_ib and frame_im";
      SI.Power totalPower=jointUSR.totalPower
        "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";

      annotation (
        preferedView="info",
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.19,
          y=0.01,
          width=0.81,
          height=0.81),
        Documentation(info="<html>
<p>
This component consists of <b>3 revolute</b> joints with parallel
axes of rotation that are connected together by two rods, see the default
animation in the following figure (the axes vectors are not part of the
default animation):
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Joints/JointRRR.png\" ALT=\"model Joints.Assemblies.JointRRR\">
</p>
<p>
This joint aggregation introduces neither constraints nor state variables and
should therefore be used in kinematic loops whenever possible to
avoid non-linear systems of equations. It is only meaningful to
use this component in <b>planar loops</b>. Basically, the position
and orientation of the 3 revolute joints as well as of frame_ia, frame_ib, and
frame_im are calculated by solving analytically a non-linear equation,
given the position and orientation at frame_a and at frame_b.
</p>
<p>
Connector <b>frame_a</b> is the \"left\" side of the first revolute joint
whereas <b>frame_ia</b> is the \"right side of this revolute joint, fixed in rod 1.
Connector <b>frame_b</b> is the \"right\" side of the third revolute joint
whereas <b>frame_ib</b> is the \"left\" side of this revolute joint, fixed in rod 2.
Finally, connector <b>frame_im</b> is the connector at the \"right\" side
of the revolute joint in the middle, fixed in rod 2.
</p>
<p>
The easiest way to define the parameters of this joint is by moving the
MultiBody system in a <b>reference configuration</b> where <b>all frames</b>
of all components are <b>parallel</b> to each other (alternatively,
at least frame_a, frame_ia, frame_im, frame_ib, frame_b of the JointRRR joint
should be parallel to each other when defining an instance of this
component).
</p>
<p>
Basically, the JointRRR model consists internally of a universal -
spherical - revolute joint aggregation (= JointUSR). In a planar
loop this will behave as if 3 revolute joints with parallel axes
are connected by rigid rods.
</p>
</html> "),
        Icon(
          Rectangle(extent=[-90, 90; 90, -90], style(color=7, fillColor=7)),
          Text(
            extent=[-127, -71; 133, -129],
            string="%name",
            style(color=3)),
          Text(
            extent=[26, 124; 68, 93],
            style(color=10),
            string="ib"),
          Text(
            extent=[-134, 128; -94, 94],
            style(color=10),
            string="ia"),
          Ellipse(extent=[-100, 25; -50, -25], style(color=0, fillColor=8)),
          Ellipse(extent=[-85, 10; -65, -10], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Ellipse(extent=[50, 25; 100, -25], style(color=0, fillColor=8)),
          Ellipse(extent=[65, 10; 85, -10], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Ellipse(extent=[-26, 80; 24, 30], style(color=0, fillColor=8)),
          Ellipse(extent=[-10, 66; 10, 46], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Polygon(points=[-71, 9; -24, 45; -19, 39; -66, 3; -71, 9], style(
                color=0, fillColor=0)),
          Polygon(points=[54, 12; 5, 47; 10, 52; 59, 18; 54, 12], style(color=0,
                 fillColor=0)),
          Polygon(points=[100, -4; 83, -4; 84, 3; 100, 3; 100, -4], style(color
                =0, fillColor=0)),
          Line(points=[80, 24; 80, 80; 80, 80; 80, 100], style(
              color=0,
              thickness=2,
              fillColor=0,
              fillPattern=1)),
          Text(
            extent=[-128, -29; 143, -62],
            string="n_a=%n_a",
            style(color=0)),
          Line(points=[0, 57; 0, 86; 0, 86; 0, 100], style(
              color=0,
              thickness=2,
              fillColor=0,
              fillPattern=1)),
          Text(
            extent=[-55, 126; -15, 92],
            style(color=10),
            string="im"),
          Line(points=[-80, 100; -80, 8], style(color=0, thickness=2)),
          Line(points=[80, 80; 101, 80], style(color=0, thickness=2)),
          Line(points=[100, 40; 93, 40; 93, 3], style(color=0, thickness=2))),
        Diagram);

      JointUSR jointUSR(
        animation=false,
        n1_a=n_a,
        n_b=n_b,
        phi_offset=phi_offset,
        rRod2_ib=rRod2_ib,
        showUniversalAxes=false,
        rRod1_ia=rRod1_ia,
        checkTotalPower=checkTotalPower,
        phi_guess=phi_guess) annotation (extent=[-30, -20; 10, 20]);

    protected
      parameter Integer ndim=if world.enableAnimation and animation then 1
           else 0;
      Visualizers.Advanced.Shape shape_rev1[ndim](
        each shapeType="cylinder",
        each color=cylinderColor,
        each length=cylinderLength,
        each width=cylinderDiameter,
        each height=cylinderDiameter,
        each lengthDirection=e_a,
        each widthDirection={0,1,0},
        each r_shape=-e_a*(cylinderLength/2),
        each r=frame_a.r_0,
        each R=frame_a.R);
      Visualizers.Advanced.Shape shape_rev2[ndim](
        each shapeType="cylinder",
        each color=cylinderColor,
        each length=cylinderLength,
        each width=cylinderDiameter,
        each height=cylinderDiameter,
        each lengthDirection=e_b,
        each widthDirection={0,1,0},
        each r_shape=-e_b*(cylinderLength/2),
        each r=frame_im.r_0,
        each R=frame_im.R);
      Visualizers.Advanced.Shape shape_rev3[ndim](
        each shapeType="cylinder",
        each color=cylinderColor,
        each length=cylinderLength,
        each width=cylinderDiameter,
        each height=cylinderDiameter,
        each lengthDirection=e_b,
        each widthDirection={0,1,0},
        each r_shape=-e_b*(cylinderLength/2),
        each r=frame_b.r_0,
        each R=frame_b.R);
      Visualizers.Advanced.Shape shape_rod1[ndim](
        each shapeType="cylinder",
        each color=rodColor,
        each length=Frames.length(rRod1_ia),
        each width=rodDiameter,
        each height=rodDiameter,
        each lengthDirection=rRod1_ia,
        each widthDirection=e_ia,
        each r=frame_ia.r_0,
        each R=frame_ia.R);
      Visualizers.Advanced.Shape shape_rod2[ndim](
        each shapeType="cylinder",
        each color=rodColor,
        each length=Frames.length(rRod2_ib),
        each width=rodDiameter,
        each height=rodDiameter,
        each lengthDirection=rRod2_ib,
        each widthDirection=e_b,
        each r=frame_ib.r_0,
        each R=frame_ib.R);
    initial equation
      n_b = Frames.resolve2(frame_b.R, Frames.resolve1(frame_a.R, n_a));
    equation
      connect(jointUSR.frame_a, frame_a)
        annotation (points=[-32, 0; -110, 0], style(color=0, thickness=2));
      connect(jointUSR.frame_b, frame_b)
        annotation (points=[12, 0; 110, 0], style(color=0, thickness=2));
      connect(jointUSR.frame_ia, frame_ia) annotation (points=[-25.8, 22; -25.8,
             70; -80, 70; -80, 110], style(color=0, thickness=2));
      connect(jointUSR.frame_im, frame_im) annotation (points=[-10, 22; -10, 70;
             -1, 70; -1, 110], style(color=0, thickness=2));
      connect(jointUSR.frame_ib, frame_ib) annotation (points=[6, 22; 6, 50; 80,
             50; 80, 110], style(color=0, thickness=2));
      connect(jointUSR.axis, axis)
        annotation (points=[12, 16; 86, 16; 86, 80; 110, 80], style(color=0));
      connect(jointUSR.bearing, bearing)
        annotation (points=[12, 8; 94, 8; 94, 40; 110, 40], style(color=0));
    end JointRRR;

    model JointRRP
      "Planar revolute - revolute - prismatic joint aggregation (no constraints, no potential states)"


      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;

      extends MultiBody.Interfaces.PartialTwoFrames;

      MultiBody.Interfaces.Frame_a frame_ia
        annotation (extent=[-95, 100; -65, 120], rotation=-90);
      MultiBody.Interfaces.Frame_b frame_im
        annotation (extent=[-16, 120; 14, 100], rotation=-90);
      MultiBody.Interfaces.Frame_b frame_ib
        annotation (extent=[65, 120; 95, 100], rotation=-90);
      Modelica.Mechanics.Translational.Interfaces.Flange_a axis
        annotation (extent=[120, 90; 100, 70]);
      Modelica.Mechanics.Translational.Interfaces.Flange_b bearing
        annotation (extent=[100, 50; 120, 30]);

      parameter Boolean animation=true "= true, if animation shall be enabled";
      parameter MultiBody.Types.Axis n_a={0,0,1}
        "Axes of the two revolute joints resolved in frame_a (both axes are parallel to each other)"
        annotation (Evaluate=true);
      parameter MultiBody.Types.Axis n_b={-1,0,0}
        "Axis of prismatic joint fixed and resolved in frame_b (must be orthogonal to revolute joint axes)"
        annotation (Evaluate=true);
      parameter SI.Position rRod1_ia[3]={1,0,0}
        "Vector from origin of frame_a to revolute joint in the middle, resolved in frame_ia"
        annotation (Evaluate=true);
      parameter SI.Position rRod2_ib[3]={-1,0,0}
        "Vector from origin of frame_ib to revolute joint in the middle, resolved in frame_ib (frame_ib is parallel to frame_b)";
      parameter SI.Position s_offset=0
        "Relative distance offset of prismatic joint (distance between the prismatic joint frames = s(t) + s_offset)";
      parameter SI.Position s_guess=0
        "Select the configuration such that at initial time |s(t0)-s_guess| is minimal";
      parameter SI.Distance cylinderLength=world.defaultJointLength
        "|Animation|if animation = true| Length of cylinders representing the revolute joints";
      parameter SI.Distance cylinderDiameter=world.defaultJointWidth
        "|Animation|if animation = true| Diameter of cylinders representing the revolute joints";
      parameter MultiBody.Types.Color cylinderColor=MultiBody.Types.Defaults.
          JointColor
        "|Animation|if animation = true| Color of cylinders representing the revolute joints";
      parameter MultiBody.Types.Axis boxWidthDirection={0,1,0}
        "|Animation|if animation = true| Vector in width direction of prismatic joint, resolved in frame_b"
        annotation (Evaluate=true);
      parameter SI.Distance boxWidth=world.defaultJointWidth
        "|Animation|if animation = true| Width of prismatic joint box";
      parameter SI.Distance boxHeight=boxWidth
        "|Animation|if animation = true| Height of prismatic joint box";
      parameter MultiBody.Types.Color boxColor=cylinderColor
        "|Animation|if animation = true| Color of prismatic joint box";
      parameter SI.Diameter rodDiameter=1.1*cylinderDiameter
        "|Animation|if animation = true| Diameter of the two rods connecting the joints";
      parameter MultiBody.Types.Color rodColor=MultiBody.Types.Defaults.
          RodColor
        "|Animation|if animation = true| Color of the two rods connecting the joints";
      parameter Boolean checkTotalPower=false
        "|Advanced|| = true, if total power flowing into this component shall be determined (must be zero)";
      final parameter Real e_a[3]=Frames.normalize(n_a)
        "Unit vector along axes of rotations, resolved in frame_a";
      final parameter Real e_ia[3]=jointUSP.e2_ia
        "Unit vector along axes of rotations, resolved in frame_ia";
      final parameter Real e_im[3](each fixed=false)
        "Unit vector along axes of rotations, resolved in frame_im";
      final parameter Real e_b[3]=jointUSP.prismatic.e
        "Unit vector along axes of translation of the prismatic joint, resolved in frame_b and frame_ib";
      SI.Power totalPower=jointUSP.totalPower
        "Total power flowing into this element, if checkTotalPower=true (otherwise dummy)";

      annotation (
        preferedView="info",
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.19,
          y=0.01,
          width=0.81,
          height=0.81),
        Documentation(info="<html>
<p>
This component consists of <b>2 revolute</b> joints with parallel
axes of rotation that and a <b>prismatic</b> joint with a translational
axis that is orthogonal to the revolute joint axes, see the default
animation in the following figure (the axes vectors are not part of the
default animation):
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Joints/JointRRP.png\" ALT=\"model Joints.Assemblies.JointRRP\">
</p>
<p>
This joint aggregation introduces neither constraints nor state variables and
should therefore be used in kinematic loops whenever possible to
avoid non-linear systems of equations. It is only meaningful to
use this component in <b>planar loops</b>. Basically, the position
and orientation of the 3 joints as well as of frame_ia, frame_ib, and
frame_im are calculated by solving analytically a non-linear equation,
given the position and orientation at frame_a and at frame_b.
</p>
<p>
Connector <b>frame_a</b> is the \"left\" side of the first revolute joint
whereas <b>frame_ia</b> is the \"right side of this revolute joint, fixed in rod 1.
Connector <b>frame_b</b> is the \"right\" side of the prismatic joint
whereas <b>frame_ib</b> is the \"left\" side of this prismatic joint, fixed in rod 2.
Finally, connector <b>frame_im</b> is the connector at the \"right\" side
of the revolute joint in the middle, fixed in rod 2. The frames
frame_b, frame_ib, frame_im are always parallel to each other.
</p>
<p>
The easiest way to define the parameters of this joint is by moving the
MultiBody system in a <b>reference configuration</b> where <b>all frames</b>
of all components are <b>parallel</b> to each other (alternatively,
at least frame_a, frame_ia, frame_im, frame_ib, frame_b of the JointRRP joint
should be parallel to each other when defining an instance of this
component).
</p>
<p>
Basically, the JointRRP model consists internally of a universal -
spherical - prismatic joint aggregation (= JointUSP). In a planar
loop this will behave as if 2 revolute joints with parallel axes
and 1 prismatic joint are connected by rigid rods.
</p>
</html> "),
        Icon(
          Rectangle(extent=[-90, 90; 90, -90], style(color=7, fillColor=7)),
          Text(
            extent=[-127, -71; 133, -129],
            string="%name",
            style(color=3)),
          Text(
            extent=[26, 124; 68, 93],
            style(color=10),
            string="ib"),
          Text(
            extent=[-134, 128; -94, 94],
            style(color=10),
            string="ia"),
          Ellipse(extent=[-100, 25; -50, -25], style(color=0, fillColor=8)),
          Ellipse(extent=[-85, 10; -65, -10], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Ellipse(extent=[-26, 80; 24, 30], style(color=0, fillColor=8)),
          Ellipse(extent=[-10, 66; 10, 46], style(
              color=0,
              fillColor=0,
              fillPattern=1)),
          Polygon(points=[-71, 9; -24, 45; -19, 39; -66, 3; -71, 9], style(
                color=0, fillColor=0)),
          Polygon(points=[54, 5; 5, 47; 8, 53; 58, 11; 54, 5], style(color=0,
                fillColor=0)),
          Text(
            extent=[-128, -29; 143, -62],
            string="n_a=%n_a",
            style(color=0)),
          Line(points=[0, 57; 0, 86; 0, 86; 0, 100], style(
              color=0,
              thickness=2,
              fillColor=0,
              fillPattern=1)),
          Text(
            extent=[-55, 126; -15, 92],
            style(color=10),
            string="im"),
          Line(points=[-80, 100; -80, 8], style(color=0, thickness=2)),
          Line(points=[80, 80; 101, 80], style(color=0, thickness=2)),
          Line(points=[100, 40; 93, 40; 93, 3], style(color=0, thickness=2)),
          Rectangle(extent=[80, 15; 100, 21], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[53, 5; 80, 11], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[53, 5; 80, -15], style(color=0, fillColor=8)),
          Rectangle(extent=[80, 15; 100, -21], style(color=0, fillColor=8)),
          Line(points=[80, 100; 80, 80; 57, 11], style(color=0, thickness=2))),

        Diagram);

      JointUSP jointUSP(
        animation=false,
        showUniversalAxes=false,
        n1_a=n_a,
        n_b=n_b,
        s_offset=s_offset,
        s_guess=s_guess,
        rRod1_ia=rRod1_ia,
        rRod2_ib=rRod2_ib,
        checkTotalPower=checkTotalPower) annotation (extent=[-30, -20; 10, 20]);

    protected
      parameter Integer ndim=if world.enableAnimation and animation then 1
           else 0;
      Visualizers.Advanced.Shape shape_rev1[ndim](
        each shapeType="cylinder",
        each color=cylinderColor,
        each length=cylinderLength,
        each width=cylinderDiameter,
        each height=cylinderDiameter,
        each lengthDirection=e_a,
        each widthDirection={0,1,0},
        each r_shape=-e_a*(cylinderLength/2),
        each r=frame_a.r_0,
        each R=frame_a.R);
      Visualizers.Advanced.Shape shape_rev2[ndim](
        each shapeType="cylinder",
        each color=cylinderColor,
        each length=cylinderLength,
        each width=cylinderDiameter,
        each height=cylinderDiameter,
        each lengthDirection=e_im,
        each widthDirection={0,1,0},
        each r_shape=-e_im*(cylinderLength/2),
        each r=frame_im.r_0,
        each R=frame_im.R);
      Visualizers.Advanced.Shape shape_prism[ndim](
        each shapeType="box",
        each color=boxColor,
        each length=jointUSP.prismatic.distance,
        each width=boxWidth,
        each height=boxHeight,
        each lengthDirection=e_b,
        each widthDirection=e_im,
        each r=frame_b.r_0,
        each R=frame_b.R);
      Visualizers.Advanced.Shape shape_rod1[ndim](
        each shapeType="cylinder",
        each color=rodColor,
        each length=Frames.length(rRod1_ia),
        each width=rodDiameter,
        each height=rodDiameter,
        each lengthDirection=rRod1_ia,
        each widthDirection=e_ia,
        each r=frame_ia.r_0,
        each R=frame_ia.R);
      Visualizers.Advanced.Shape shape_rod2[ndim](
        each shapeType="cylinder",
        each color=rodColor,
        each length=Frames.length(rRod2_ib),
        each width=rodDiameter,
        each height=rodDiameter,
        each lengthDirection=rRod2_ib,
        each widthDirection=e_b,
        each r=frame_ib.r_0,
        each R=frame_ib.R);
    initial equation
      e_im = Frames.resolve2(frame_im.R, Frames.resolve1(frame_a.R, e_a));
    equation
      connect(jointUSP.frame_a, frame_a)
        annotation (points=[-32, 0; -110, 0], style(color=0, thickness=2));
      connect(jointUSP.frame_b, frame_b)
        annotation (points=[12, 0; 110, 0], style(color=0, thickness=2));
      connect(jointUSP.frame_ia, frame_ia) annotation (points=[-25.8, 22; -25.8,
             70; -80, 70; -80, 110], style(color=0, thickness=2));
      connect(jointUSP.frame_im, frame_im) annotation (points=[-10, 22; -10, 70;
             -1, 70; -1, 110], style(color=0, thickness=2));
      connect(jointUSP.frame_ib, frame_ib) annotation (points=[6, 22; 6, 50; 80,
             50; 80, 110], style(color=0, thickness=2));
      connect(jointUSP.axis, axis)
        annotation (points=[12, 16; 86, 16; 86, 80; 110, 80], style(color=0));
      connect(jointUSP.bearing, bearing)
        annotation (points=[12, 8; 94, 8; 94, 40; 110, 40], style(color=0));
    end JointRRP;
  end Assemblies;

  package Internal
    "Components used for analytic solution of kinematic loops (use only if you know what you are doing)"


    extends Modelica.Icons.Library;
    model Revolute
      "Revolute joint (1 rotational degree-of-freedom, 2 potential states)"

      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;
      import T = MultiBody.Frames.TransformationMatrices;
      Interfaces.Frame_a frame_a annotation (extent=[-120, -15; -100, 15]);
      Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);

      parameter Boolean animation=true
        "= true, if animation shall be enabled (show axis as cylinder)";
      parameter MultiBody.Types.Axis n={0,0,1}
        "Axis of rotation resolved in frame_a (= same as in frame_b)"
        annotation (Evaluate=true);
      parameter Cv.NonSIunits.Angle_deg phi_offset=0
        "Relative angle offset (angle = phi + from_deg(phi_offset))"
        annotation (Evaluate=false);
      parameter Types.Init.Temp initType=Types.Init.Free
        "|Initialization| Type of initialization (defines usage of start values below)";
      parameter Cv.NonSIunits.Angle_deg phi_start=0
        "|Initialization| Initial value of rotation angle phi (fixed or guess value)"
        annotation (Evaluate=false);
      parameter MultiBody.Types.AngularVelocity_degs w_start=0
        "|Initialization| Initial value of relative angular velocity w = der(phi)"
        annotation (Evaluate=false);
      parameter MultiBody.Types.AngularAcceleration_degs2 a_start=0
        "|Initialization| Initial value of relative angular acceleration a = der(w)"
        annotation (Evaluate=false);
      parameter SI.Distance cylinderLength=world.defaultJointLength
        "|Animation|if animation = true| Length of cylinder representing the joint axis";
      parameter SI.Distance cylinderDiameter=world.defaultJointWidth
        "|Animation|if animation = true| Diameter of cylinder representing the joint axis";
      parameter MultiBody.Types.Color cylinderColor=Types.Defaults.JointColor
        "|Animation|if animation = true| Color of cylinder representing the joint axis";

      parameter Boolean enforceStates=false
        "|Advanced|| = true, if generalized variables (phi,w) shall be used as states";
      parameter Boolean planarCutJoint=false
        "|Advanced|| = true, if joint shall be used as cut-joint in a planar loop";

      SI.Angle phi(start=Cv.from_deg(phi_start), stateSelect=if enforceStates
             then StateSelect.always else if planarCutJoint then StateSelect.
            never else StateSelect.prefer)
        "Relative rotation angle from frame_a to frame_b = phi + from_deg(phi_offset))"
         annotation (unassignedMessage="
The rotation angle phi of a revolute joint cannot be determined.
A non-zero mass might be missing on either side of the parts
connected to the revolute joint.
");
      SI.AngularVelocity w(stateSelect=if enforceStates then StateSelect.always
             else if planarCutJoint then StateSelect.never else StateSelect.
            prefer) "First derivative of angle phi (relative angular velocity)";
      SI.AngularAcceleration a
        "Second derivative of angle phi (relative angular acceleration)";
      SI.Torque tau=0 "Driving torque in direction of axis of rotation";
      SI.Angle angle "= from_deg(phi_offset) + phi";
      annotation (
        preferedView="info",
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.05,
          y=0.09,
          width=0.65,
          height=0.69),
        Icon(
          Rectangle(extent=[-20, 10; 20, -10], style(
              color=0,
              gradient=0,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-100, -60; -20, 60], style(
              color=8,
              gradient=2,
              fillColor=8)),
          Rectangle(extent=[20, -60; 100, 60], style(
              color=8,
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-100, 60; -20, -59], style(color=0)),
          Rectangle(extent=[20, 60; 100, -60], style(color=0)),
          Text(
            extent=[-99, 12; -63, -13],
            style(color=10),
            string="a"),
          Text(
            extent=[63, 11; 99, -14],
            style(color=10),
            string="b")),
        Diagram(
          Rectangle(extent=[-100, -60; -20, 60], style(
              color=8,
              gradient=2,
              fillColor=8)),
          Rectangle(extent=[-20, 10; 20, -10], style(
              color=0,
              gradient=0,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[20, -60; 100, 60], style(
              color=8,
              gradient=2,
              fillColor=8,
              fillPattern=1))),
        Documentation(info="<HTML>
<p>
Joint where frame_b rotates around axis n which is fixed in frame_a.
The two frames coincide when \"phi + phi_offset = 0\", where
\"phi_offset\" is a parameter with a zero default
and \"phi\" is the rotation angle.
</p>
<p>
In the \"Advanced\" menu it can be defined via parameter <b>enforceStates</b>
that the rotation angle \"phi\" and its derivative shall be definitely
used as states (this means that the Modelica attributes stateSelect=StateSelect.always
are set on these variables). The states are usually selected automatically.
In certain situations, especially when closed kinematic loops are present,
it might be slightly more efficient, when using the \"enforceStates\" setting.
</p>
<p>
If a <b>planar loop</b> is present, e.g., consisting of 4 revolute joints
where the joint axes are all parallel to each other, then there is no
longer a unique mathematical solution and the symbolic algorithms will
fail. Usually, an error message will be printed pointing out this
situation. In this case, parameter <b>planarCutJoint</b> in the \"Advanced\"
menu of one of the revolute joints has to be set to <b>true</b>. The
effect is that from the 5 constraints of a usual revolute joint,
3 constraints are removed and replaced by appropriate known
variables (e.g., the force in the direction of the axis of rotation is
treated as known with value equal to zero; for standard revolute joints,
this force is an unknown quantity).
</p>
</HTML>
"));
    protected
      outer MultiBody.World world;
      parameter Real e[3]=Frames.normalize(n)
        "Unit vector in direction of rotation axis, resolved in frame_a (= same as in frame_b)";
      parameter Real nnx_a[3]=if abs(e[1]) > 0.1 then {0,1,0} else (if abs(e[2])
           > 0.1 then {0,0,1} else {1,0,0})
        "Arbitrary vector that is not aligned with rotation axis n"
        annotation (Evaluate=true);
      parameter Real ey_a[3]=Frames.normalize(cross(e, nnx_a))
        "Unit vector orthogonal to axis n of revolute joint, resolved in frame_a"
        annotation (Evaluate=true);
      parameter Real ex_a[3]=cross(ey_a, e)
        "Unit vector orthogonal to axis n of revolute joint and to ey_a, resolved in frame_a"
        annotation (Evaluate=true);
      Real ey_b[3] "ey_a, resolved in frame_b";
      Real ex_b[3] "ex_a, resolved in frame_b";
      Frames.Orientation R_rel
        "Dummy or relative orientation object from frame_a to frame_b";
      Frames.Orientation R_rel_inv
        "Dummy or relative orientation object from frame_b to frame_a";
      Real r_rel_a[3]
        "Position vector from origin of frame_a to origin of frame_b, resolved in frame_a";
      SI.Force f_c[2] "Dummy or constraint forces in direction of ex_a, ey_a";
      parameter Integer ndim=if world.enableAnimation and animation then 1
           else 0;
      Visualizers.Advanced.Shape cylinder[ndim](
        each shapeType="cylinder",
        each color=cylinderColor,
        each length=cylinderLength,
        each width=cylinderDiameter,
        each height=cylinderDiameter,
        each lengthDirection=e,
        each widthDirection={0,1,0},
        each r_shape=-e*(cylinderLength/2),
        each r=frame_a.r_0,
        each R=frame_a.R);
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
        "Connector frame_a of revolute joint is not connected");
      assert(cardinality(frame_b) > 0,
        "Connector frame_b of revolute joint is not connected");

      if not planarCutJoint then
        defineBranch(frame_a.R, frame_b.R);

        angle = Cv.from_deg(phi_offset) + phi;
        w = der(phi);
        a = der(w);

        // relationships between quantities of frame_a and of frame_b
        R_rel = Frames.planarRotation(e, angle, der(angle));
        frame_b.r_0 = frame_a.r_0;

        if rooted(frame_a.R) then
          R_rel_inv = Frames.nullRotation();
          frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);
          frame_a.f = -Frames.resolve1(R_rel, frame_b.f);
          frame_a.t = -Frames.resolve1(R_rel, frame_b.t);
        else
          R_rel_inv = Frames.Orientation(T=transpose(R_rel.T), w=-e*der(angle));
          frame_a.R = Frames.absoluteRotation(frame_b.R, R_rel_inv);
          frame_b.f = -Frames.resolve2(R_rel, frame_a.f);
          frame_b.t = -Frames.resolve2(R_rel, frame_a.t);
        end if;

        // d'Alemberts principle
        tau = -frame_b.t*e;

        // Set not used variables to arbitrary value
        r_rel_a = zeros(3);
        f_c = zeros(2);
        ex_b = zeros(3);
        ey_b = zeros(3);
      else
        // Determine relative position vector resolved in frame_a
        R_rel = Frames.relativeRotation(frame_a.R, frame_b.R);
        r_rel_a = T.resolve1(R_rel.T, T.resolve2(frame_b.R.T, frame_b.r_0 -
          frame_a.r_0));


          // r_rel_a = (frame_a.R.T*transpose(frame_b.R.T))*frame_b.R.T*(frame_b.r_0 - frame_a.r_0);

        // Constraint equations
        0 = ex_a*r_rel_a;
        0 = ey_a*r_rel_a;

        /* Transform forces and torques
       (Note that e has the same coordinates in frame_a and in frame_b
        and therefore a simplified transformation of the torque in
        direction of the rotation axis can be performed. The torques
        perpendicular to this axis are assumed to be zero by the
        assumption of a planar joint)
    */
        frame_b.t = -e*tau;
        frame_a.t = -frame_b.t;

        frame_a.f = [ex_a, ey_a]*f_c;
        frame_b.f = -Frames.resolve2(R_rel, frame_a.f);

        //angle = planarRotationAngle(e, npx, npx_b);
        angle = 0;
        phi = 0;
        w = 0;
        a = 0;

        // dummy
        R_rel_inv = Frames.nullRotation();

        // check that revolute joint is used in planar loop
        ex_b = Frames.resolve2(R_rel, ex_a);
        ey_b = Frames.resolve2(R_rel, ey_a);
        assert(noEvent(abs(e*r_rel_a) <= 1.e-10 and abs(e*ex_b) <= 1.e-10 and
          abs(e*ey_b) <= 1.e-10), "
The revolute joint is used with parameter
planarCutJoint=true. However, the revolute joint
is not part of a planar loop where the axis of the
revolute joint (parameter n) is orthogonal to the
possible movements. Either set planarCutJoint=false
or correct the definition of the axes vectors n
in the revolute joints of the planar loop.
");
      end if;
    end Revolute;

    model Prismatic
      "Prismatic joint (1 translational degree-of-freedom, 2 potential states)"


      import SI = Modelica.SIunits;
      extends MultiBody.Interfaces.PartialElementaryJoint;
      parameter Boolean animation=true "= true, if animation shall be enabled";
      parameter MultiBody.Types.Axis n={1,0,0}
        "Axis of translation resolved in frame_a (= same as in frame_b)"
        annotation (Evaluate=true);
      parameter SI.Position s_offset=0
        "Relative distance offset (distance between frame_a and frame_b = s_offset + s)"
        annotation (Evaluate=false);
      parameter Types.Init.Temp initType=Types.Init.Free
        "|Initialization| Type of initialization (defines usage of start values below)";
      parameter SI.Position s_start=0
        "|Initialization| Initial value of distance (fixed or guess value)"
        annotation (Evaluate=false);
      parameter SI.Velocity v_start=0
        "|Initialization| Initial value of relative velocity v = der(s)"
        annotation (Evaluate=false);
      parameter SI.Acceleration a_start=0
        "|Initialization| Initial value of relative acceleration a = der(v)"
        annotation (Evaluate=false);
      parameter MultiBody.Types.Axis boxWidthDirection={0,1,0}
        "|Animation|if animation = true| Vector in width direction of box, resolved in frame_a"
        annotation (Evaluate=true);
      parameter SI.Distance boxWidth=world.defaultJointWidth
        "|Animation|if animation = true| Width of prismatic joint box";
      parameter SI.Distance boxHeight=boxWidth
        "|Animation|if animation = true| Height of prismatic joint box";
      parameter MultiBody.Types.Color boxColor=Types.Defaults.JointColor
        "|Animation|if animation = true| Color of prismatic joint box";
      parameter Boolean enforceStates=false
        "|Advanced|| = true, if generalized variables (s,v) shall be used as states";
      final parameter Real e[3]=Frames.normalize(n)
        "Unit vector in direction of prismatic axis n";

      SI.Position s(start=s_start, stateSelect=if enforceStates then
            StateSelect.always else StateSelect.prefer)
        "Relative distance between frame_a and frame_b = s + s_offset)"
        annotation (unassignedMessage="
The relative distance s of a prismatic joint cannot be determined.
A non-zero mass might be missing on either side of the parts
connected to the prismatic joint.");

      SI.Velocity v(stateSelect=if enforceStates then StateSelect.always else
            StateSelect.prefer) "First derivative of s (relative velocity)";
      SI.Acceleration a;
      SI.Force f=0 "Actuation force in direction of joint axis";

      annotation (
        preferedView="info",
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.2,
          y=0.01,
          width=0.67,
          height=0.79),
        Icon(
          Rectangle(extent=[-100, -50; -30, 41], style(pattern=0, fillColor=8)),

          Rectangle(extent=[-100, 40; -30, 50], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[-30, -30; 100, 20], style(pattern=0, fillColor=8)),

          Rectangle(extent=[-30, 20; 100, 30], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Line(points=[-30, -50; -30, 50], style(color=0)),
          Line(points=[100, -30; 100, 21], style(color=0)),
          Text(
            extent=[60, 12; 96, -13],
            string="b",
            style(color=10)),
          Text(
            extent=[-95, 13; -60, -9],
            string="a",
            style(color=10))),
        Diagram(
          Rectangle(extent=[-100, -50; -30, 40], style(pattern=0, fillColor=8)),

          Rectangle(extent=[-100, 40; -30, 50], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[-30, -30; 100, 20], style(pattern=0, fillColor=8)),

          Rectangle(extent=[-30, 20; 100, 30], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Line(points=[-30, -50; -30, 50], style(color=0)),
          Polygon(points=[90, -64; 100, -67; 90, -70; 90, -64], style(color=10,
                 fillColor=10)),
          Line(points=[-31, -67; 90, -67], style(color=10)),
          Text(
            extent=[12, -67; 49, -80],
            style(color=10),
            string="s"),
          Line(points=[100, -70; 100, -30], style(
              color=10,
              fillColor=10,
              fillPattern=1)),
          Line(points=[-100, -67; -40, -67], style(color=10)),
          Polygon(points=[-40, -64; -30, -67; -40, -70; -40, -64], style(color=
                  10, fillColor=10)),
          Text(
            extent=[-83, -69; -49, -84],
            style(color=10),
            string="s_offset"),
          Line(points=[-100, -70; -100, -50], style(
              color=10,
              fillColor=10,
              fillPattern=1)),
          Line(points=[100, -30; 100, 29], style(color=0)),
          Line(points=[-30, -70; -30, -50], style(
              color=10,
              fillColor=10,
              fillPattern=1))),
        Documentation(info="<HTML>
<p>
Joint where frame_b is translated along axis n which is fixed in frame_a.
The two frames coincide when \"s + s_offset = 0\", where
\"s_offset\" is a parameter with a zero default
and \"s\" is the relative distance.
</p>
<p>
In the \"Advanced\" menu it can be defined via parameter <b>enforceStates</b>
that the relative distance \"s\" and its derivative shall be definitely
used as states (this means that the Modelica attributes stateSelect=StateSelect.always
are set on these variables). The states are usually selected automatically.
In certain situations, especially when closed kinematic loops are present,
it might be slightly more efficient, when using the \"enforceStates\" setting.
</p>
</HTML>
"));

    protected
      parameter Integer ndim=if world.enableAnimation and animation then 1
           else 0;
      Visualizers.Advanced.Shape box[ndim](
        each shapeType="box",
        each color=boxColor,
        each length=if noEvent(abs(s + s_offset) > 1.e-6) then s + s_offset
             else 1.e-6,
        each width=boxWidth,
        each height=boxHeight,
        each lengthDirection=e,
        each widthDirection=boxWidthDirection,
        each r=frame_a.r_0,
        each R=frame_a.R);
    initial equation
      if initType == Types.Init.PositionVelocity then
        s = s_start;
        v = v_start;
      elseif initType == Types.Init.SteadyState then
        v = 0;
        a = 0;
      elseif initType == Types.Init.Position then
        s = s_start;
      elseif initType == Types.Init.Velocity then
        v = v_start;
      elseif initType == Types.Init.VelocityAcceleration then
        v = v_start;
        a = a_start;
      elseif initType == Types.Init.PositionVelocityAcceleration then
        s = s_start;
        v = v_start;
        a = a_start;
      end if;
      // define potential states
    equation
      v = der(s);
      a = der(v);

      // relationships between kinematic quantities of frame_a and of frame_b
      frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, e*(s_offset + s));
      frame_b.R = frame_a.R;

      // Force and torque balance
      zeros(3) = frame_a.f + frame_b.f;
      zeros(3) = frame_a.t + frame_b.t + cross(e*(s_offset + s), frame_b.f);

      // d'Alemberts principle
      f = -e*frame_b.f;
    end Prismatic;

    model RevoluteWithLengthConstraint
      "Revolute joint where the rotation angle is computed from a length constraint (1 degree-of-freedom, no potential state)"


      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;
      extends MultiBody.Interfaces.PartialTwoFrames;
      Modelica.Blocks.Interfaces.InPort position_a(n=3, redeclare type
          SignalType = SI.Position)
        "Position vector from frame_a to frame_a side of length constraint, resolved in frame_a of revolute joint"
        annotation (extent=[-140, -80; -100, -40]);
      Modelica.Blocks.Interfaces.InPort position_b(n=3, redeclare type
          SignalType = SI.Position)
        "Position vector from frame_b to frame_b side of length constraint, resolved in frame_b of revolute joint"
        annotation (extent=[140, -80; 100, -40]);

      parameter Boolean animation=true "= true, if animation shall be enabled";
      parameter SI.Position lengthConstraint=1
        "Fixed length of length constraint";
      parameter MultiBody.Types.Axis n={0,0,1}
        "Axis of rotation resolved in frame_a (= same as in frame_b)"
        annotation (Evaluate=true);
      parameter Cv.NonSIunits.Angle_deg phi_offset=0
        "Relative angle offset (angle = phi + from_deg(phi_offset))";
      parameter Cv.NonSIunits.Angle_deg phi_guess=0
        "Select the configuration such that at initial time |phi - from_deg(phi_guess)| is minimal";
      parameter SI.Distance cylinderLength=world.defaultJointLength
        "|Animation|if animation = true| Length of cylinder representing the joint axis";
      parameter SI.Distance cylinderDiameter=world.defaultJointWidth
        "|Animation|if animation = true| Diameter of cylinder representing the joint axis";
      parameter MultiBody.Types.Color cylinderColor=Types.Defaults.JointColor
        "|Animation|if animation = true| Color of cylinder representing the joint axis";

      parameter Boolean axisTorqueBalance=true
        "|Advanced|| = true, if torque balance of flange axis with the frame_b connector (axis.tau = -e*frame_b.t) shall be defined. Otherwise this equation has to be provided outside of this joint";
      final parameter Boolean positiveBranch(fixed=false)
        "Based on phi_guess, selection of one of the two solutions of the non-linear constraint equation";
      final parameter Real e[3]=MultiBody.Frames.normalize(n)
        "Unit vector in direction of rotation axis, resolved in frame_a";

      SI.Angle phi "Rotation angle of revolute joint";
      Frames.Orientation R_rel
        "Relative orientation object from frame_a to frame_b";
      SI.Angle angle
        "= phi + from_deg(phi_offset) (relative rotation angle between frame_a and frame_b)";
      SI.Torque tau "= axis.tau (driving torque in the axis)";

      annotation (
        preferedView="info",
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.05,
          y=0.09,
          width=0.65,
          height=0.69),
        Icon(
          Rectangle(extent=[-30, 10; 10, -10], style(
              color=0,
              gradient=0,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[-100, -60; -29, 61], style(
              color=8,
              gradient=2,
              fillColor=8)),
          Rectangle(extent=[30, -60; 100, 60], style(
              color=8,
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Text(extent=[-139, -168; 137, -111], string="%name"),
          Rectangle(extent=[-100, 60; -29, -59], style(color=0)),
          Rectangle(extent=[30, 60; 100, -60], style(color=0)),
          Text(
            extent=[-142, -108; 147, -69],
            string="n=%n",
            style(color=0)),
          Line(points=[-60, 60; -60, 90], style(color=0)),
          Line(points=[-20, 70; -60, 70], style(color=0)),
          Line(points=[-20, 80; -20, 60], style(color=0)),
          Line(points=[20, 80; 20, 60], style(color=0)),
          Line(points=[20, 70; 41, 70], style(color=0)),
          Polygon(points=[-9, 30; 10, 30; 30, 50; -29, 50; -9, 30], style(
              color=0,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[10, 30; 30, 50; 30, -51; 10, -31; 10, 30], style(
                color=0, fillColor=8)),
          Rectangle(extent=[-10, 90; 10, 50], style(
              color=0,
              gradient=1,
              fillColor=8))),
        Diagram(
          Rectangle(extent=[-100, -60; -30, 60], style(
              color=8,
              gradient=2,
              fillColor=8)),
          Rectangle(extent=[-30, 10; 10, -10], style(
              color=0,
              gradient=0,
              fillColor=8,
              fillPattern=1)),
          Rectangle(extent=[30, -60; 100, 60], style(
              color=8,
              gradient=2,
              fillColor=8,
              fillPattern=1)),
          Line(points=[-60, 60; -60, 90], style(color=0)),
          Line(points=[-20, 70; -60, 70], style(color=0)),
          Line(points=[-20, 80; -20, 60], style(color=0)),
          Line(points=[20, 80; 20, 60], style(color=0)),
          Line(points=[20, 70; 41, 70], style(color=0)),
          Polygon(points=[-9, 30; 10, 30; 30, 50; -29, 50; -9, 30], style(
              color=0,
              fillColor=8,
              fillPattern=1)),
          Polygon(points=[10, 30; 30, 50; 30, -51; 10, -31; 10, 30], style(
                color=0, fillColor=8)),
          Rectangle(extent=[-10, 50; 10, 91], style(
              color=0,
              gradient=1,
              fillColor=8))),
        Documentation(info="<HTML>
<p>
Joint where frame_b rotates around axis n which is fixed in frame_a.
The two frames coincide when \"phi + phi_offset = 0\", where
\"phi_offset\" is a parameter with a zero default
and \"phi\" is the rotation angle.
</p>
<p>
This variant of the revolute joint is designed to work together
with a length constraint in a kinematic loop. This means that the
angle of the revolute joint, phi, is computed such that the
length constraint is fulfilled.
</p>
<p>
<b>Usually, this joint should not be used by a user of the MultiBody
library. It is only provided to built-up the MultiBody.Joints.Assemblies.JointXYZ
joints.</b>
</p>
</HTML>
"));

    protected
      SI.Position r_a[3]=position_a.signal
        "Position vector from frame_a to frame_a side of length constraint, resolved in frame_a of revolute joint";
      SI.Position r_b[3]=position_b.signal
        "Position vector from frame_b to frame_b side of length constraint, resolved in frame_b of revolute joint";
      Real e_r_a "Projection of r_a on e";
      Real e_r_b "Projection of r_b on e";
      Real A "Coefficient A of equation: A*cos(phi) + B*sin(phi) + C = 0";
      Real B "Coefficient B of equation: A*cos(phi) + B*sin(phi) + C = 0";
      Real C "Coefficient C of equation: A*cos(phi) + B*sin(phi) + C = 0";
      Real k1 "Constant of quadratic equation";
      Real k2 "Constant of quadratic equation";
      Real k1a(start=1);
      Real k1b;
      Real kcos_angle "= k1*cos(angle)";
      Real ksin_angle "= k1*sin(angle)";

      parameter Integer ndim=if world.enableAnimation and animation then 1
           else 0;
      Visualizers.Advanced.Shape cylinder[ndim](
        each shapeType="cylinder",
        each color=cylinderColor,
        each length=cylinderLength,
        each width=cylinderDiameter,
        each height=cylinderDiameter,
        each lengthDirection=e,
        each widthDirection={0,1,0},
        each r_shape=-e*(cylinderLength/2),
        each r=frame_a.r_0,
        each R=frame_a.R);

      function selectBranch
        "Determine branch which is closest to initial angle=0"

        import Modelica.Math.*;
        input SI.Length L "Length of length constraint";
        input Real e[3]
          "Unit vector along axis of rotation, resolved in frame_a (= same in frame_b)";
        input SI.Angle angle_guess
          "Select the configuration such that at initial time |angle-angle_guess| is minimal (angle=0: frame_a and frame_b coincide)";
        input SI.Position r_a[3]
          "Position vector from frame_a to frame_a side of length constraint, resolved in frame_a of revolute joint";
        input SI.Position r_b[3]
          "Position vector from frame_b to frame_b side of length constraint, resolved in frame_b of revolute joint";
        output Boolean positiveBranch "Branch of the initial solution";
      protected
        Real e_r_a "Projection of r_a on e";
        Real e_r_b "Projection of r_b on e";
        Real A "Coefficient A of equation: A*cos(phi) + B*sin(phi) + C = 0";
        Real B "Coefficient B of equation: A*cos(phi) + B*sin(phi) + C = 0";
        Real C "Coefficient C of equation: A*cos(phi) + B*sin(phi) + C = 0";
        Real k1 "Constant of quadratic equation";
        Real k2 "Constant of quadratic equation";
        Real kcos1 "k1*cos(angle1)";
        Real ksin1 "k1*sin(angle1)";
        Real kcos2 "k2*cos(angle2)";
        Real ksin2 "k2*sin(angle2)";
        SI.Angle angle1 "solution 1 of nonlinear equation";
        SI.Angle angle2 "solution 2 of nonlinear equation";
      algorithm
        /* The position vector r_rel from frame_a to frame_b of the length constraint
       element, resolved in frame_b of the revolute joint is given by
       (T_rel is the planar transformation matrix from frame_a to frame_b of
        the revolute joint):
          r_rel = r_b - T_rel*r_a
       The length constraint can therefore be formulated as:
          r_rel*r_rel = L*L
       with
          (r_b - T_rel*r_a)*(r_b - T_rel*r_a)
             = r_b*r_b - 2*r_b*T_rel*r_a + r_a*transpose(T_rel)*T_rel*r_a
             = r_b*r_b + r_a*r_a - 2*r_b*T_rel*r_a
       follows
          (1) 0 = r_a*r_a + r_b*r_b - 2*r_b*T_rel*r_a - L*L
       The vectors r_a, r_b and parameter L are NOT a function of
       the angle of the revolute joint. Since T_rel = T_rel(angle) is a function
       of the unknown angle of the revolute joint, this is a non-linear
       equation in this angle.
          T_rel = [e]*tranpose([e]) + (identity(3) - [e]*transpose([e]))*cos(angle)
                  - skew(e)*sin(angle);
       with
          r_b*T_rel*r_a
             = r_b*(e*(e*r_a) + (r_a - e*(e*r_a))*cos(angle) - cross(e,r_a)*sin(angle)
             = (e*r_b)*(e*r_a) + (r_b*r_a - (e*r_b)*(e*r_a))*cos(angle) - r_b*cross(e,r_a)*sin(angle)
       follows for the constraint equation (1)
          (2) 0 = r_a*r_a + r_b*r_b - L*L
                  - 2*(e*r_b)*(e*r_a)
                  - 2*(r_b*r_a - (e*r_b)*(e*r_a))*cos(angle)
                  + 2*r_b*cross(e,r_a)*sin(angle)
       or
          (3) A*cos(angle) + B*sin(angle) + C = 0
       with
              A = -2*(r_b*r_a - (e*r_b)*(e*r_a))
              B = 2*r_b*cross(e,r_a)
              C = r_a*r_a + r_b*r_b - L*L - 2*(e*r_b)*(e*r_a)
       Equation (3) is solved by computing sin(angle) and cos(angle)
       independently from each other. This allows to compute
       angle in the range: -180 deg <= angle <= 180 deg
    */
        e_r_a := e*r_a;
        e_r_b := e*r_b;
        A := -2*(r_b*r_a - e_r_b*e_r_a);
        B := 2*r_b*cross(e, r_a);
        C := r_a*r_a + r_b*r_b - L*L - 2*e_r_b*e_r_a;
        k1 := A*A + B*B;
        k2 := sqrt(k1 - C*C);

        kcos1 := -A*C + B*k2;
        ksin1 := -B*C - A*k2;
        angle1 := atan2(ksin1, kcos1);

        kcos2 := -A*C - B*k2;
        ksin2 := -B*C + A*k2;
        angle2 := atan2(ksin2, kcos2);

        if abs(angle1 - angle_guess) <= abs(angle2 - angle_guess) then
          positiveBranch := true;
        else
          positiveBranch := false;
        end if;
      end selectBranch;
      annotation (Diagram);
    public
      Modelica.Mechanics.Rotational.Interfaces.Flange_b bearing
        annotation (extent=[-70, 110; -50, 90]);
      Modelica.Mechanics.Rotational.Interfaces.Flange_a axis
        annotation (extent=[10, 110; -10, 90]);
    initial equation
      positiveBranch = selectBranch(lengthConstraint, e, Cv.from_deg(phi_offset
         + phi_guess), r_a, r_b);
    equation
      axis.tau = tau;
      axis.phi = phi;
      bearing.phi = 0;

      angle = Cv.from_deg(phi_offset) + phi;

      // transform kinematic quantities from frame_a to frame_b
      frame_b.r_0 = frame_a.r_0;

      R_rel = Frames.planarRotation(e, angle, der(angle));
      frame_b.R = Frames.absoluteRotation(frame_a.R, R_rel);

      // Transform the force and torque acting at frame_b to frame_a
      zeros(3) = frame_a.f + Frames.resolve1(R_rel, frame_b.f);
      zeros(3) = frame_a.t + Frames.resolve1(R_rel, frame_b.t);

      if axisTorqueBalance then
        /* Note, if axisTorqueBalance is false, the force in the
       length constraint must be calculated such that the driving
       Torque in direction of the rotation axis is:
          axis.tau = -e*frame_b.t;
       If axisTorqueBalance=true, this equation is provided here.
       As a consequence, the force in the length constraint and the second
       derivative of 'angle' will be part of a linear algebraic system of
       equations (otherwise, it might be possible to remove this force
       from the linear system).
    */
        tau = -e*frame_b.t;
      end if;

      // Compute rotation angle (details, see function "selectBranch")
      e_r_a = e*r_a;
      e_r_b = e*r_b;
      A = -2*(r_b*r_a - e_r_b*e_r_a);
      B = 2*r_b*cross(e, r_a);
      C = r_a*r_a + r_b*r_b - lengthConstraint*lengthConstraint - 2*e_r_b*e_r_a;
      k1 = A*A + B*B;
      k1a = k1 - C*C;

      assert(k1a > 1.e-10, "
Singular position of loop (either no or two analytic solutions;
the mechanism has lost one-degree-of freedom in this position).
Try first to use another MultiBody.Joints.Assemblies.JointXXX component.
In most cases it is best that the joints outside of the JointXXX
component are revolute and NOT prismatic joints. If this also
lead to singular positions, it could be that this kinematic loop
cannot be solved analytically. In this case you have to build
up the loop with basic joints (NO aggregation JointXXX components)
and rely on dynamic state selection, i.e., during simulation
the states will be dynamically selected in such a way that in no
position a degree of freedom is lost.
");

      k1b = Frames.Internal.maxWithoutEvent(k1a, 1.0e-12);
      k2 = sqrt(k1b);
      kcos_angle = -A*C + (if positiveBranch then B else -B)*k2;
      ksin_angle = -B*C + (if positiveBranch then -A else A)*k2;

      angle = Modelica.Math.atan2(ksin_angle, kcos_angle);
    end RevoluteWithLengthConstraint;

    model PrismaticWithLengthConstraint
      "Prismatic joint where the translational distance is computed from a length constraint (1 degree-of-freedom, no potential state)"


      import SI = Modelica.SIunits;
      import Cv = Modelica.SIunits.Conversions;
      extends MultiBody.Interfaces.PartialTwoFrames;
      Modelica.Mechanics.Translational.Interfaces.Flange_a axis
        annotation (extent=[70, 80; 90, 60]);
      Modelica.Mechanics.Translational.Interfaces.Flange_b bearing
        annotation (extent=[-30, 80; -50, 60]);
      Modelica.Blocks.Interfaces.InPort position_a(n=3, redeclare type
          SignalType = SI.Position)
        "Position vector from frame_a to frame_a side of length constraint, resolved in frame_a of revolute joint"
        annotation (extent=[-140, -80; -100, -40]);
      Modelica.Blocks.Interfaces.InPort position_b(n=3, redeclare type
          SignalType = SI.Position)
        "Position vector from frame_b to frame_b side of length constraint, resolved in frame_b of revolute joint"
        annotation (extent=[140, -80; 100, -40]);

      parameter Boolean animation=true "= true, if animation shall be enabled";
      parameter SI.Position length=1 "Fixed length of length constraint";
      parameter MultiBody.Types.Axis n={1,0,0}
        "Axis of translation resolved in frame_a (= same as in frame_b)"
        annotation (Evaluate=true);
      parameter SI.Position s_offset=0
        "Relative distance offset (distance between frame_a and frame_b = s(t) + s_offset)";
      parameter SI.Position s_guess=0
        "Select the configuration such that at initial time |s(t0)-s_guess| is minimal";
      parameter MultiBody.Types.Axis boxWidthDirection={0,1,0}
        "|Animation|if animation = true| Vector in width direction of box, resolved in frame_a"
        annotation (Evaluate=true);
      parameter SI.Distance boxWidth=world.defaultJointWidth
        "|Animation|if animation = true| Width of prismatic joint box";
      parameter SI.Distance boxHeight=boxWidth
        "|Animation|if animation = true| Height of prismatic joint box";
      parameter MultiBody.Types.Color boxColor=Types.Defaults.JointColor
        "|Animation|if animation = true| Color of prismatic joint box";
      parameter Boolean axisForceBalance=true
        "|Advanced|| = true, if force balance of flange axis with the frame_b connector (axis.f = -e*frame_b.f) shall be defined. Otherwise this equation has to be provided outside of this joint";
      final parameter Boolean positiveBranch(fixed=false)
        "Selection of one of the two solutions of the non-linear constraint equation";
      final parameter Real e[3]=MultiBody.Frames.normalize(n)
        "Unit vector in direction of translation axis, resolved in frame_a";
      SI.Position s
        "Relative distance between frame_a and frame_b along axis n = s + s_offset)";
      SI.Position distance
        "Relative distance between frame_a and frame_b along axis n";
      SI.Position r_rel_a[3]
        "Position vector from frame_a to frame_b resolved in frame_a";
      SI.Force f "= axis.f (driving force in the axis)";

      annotation (
        preferedView="info",
        Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[1, 1],
          component=[20, 20]),
        Window(
          x=0.05,
          y=0.09,
          width=0.65,
          height=0.69),
        Icon(
          Rectangle(extent=[-30, -40; 100, 30], style(pattern=0, fillColor=8)),

          Rectangle(extent=[-30, 40; 100, -40], style(color=0)),
          Rectangle(extent=[-100, -60; -30, 50], style(pattern=0, fillColor=8)),

          Rectangle(extent=[-100, 50; -30, 60], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[-30, 30; 100, 40], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Text(extent=[-136, -170; 140, -113], string="%name"),
          Rectangle(extent=[-100, 60; -30, -60], style(color=0)),
          Line(points=[100, -40; 100, -60]),
          Rectangle(extent=[100, 40; 90, 80], style(color=0, fillColor=8)),
          Text(
            extent=[-136, -116; 153, -77],
            string="n=%n",
            style(color=0))),
        Diagram(
          Line(points=[-30, -50; -30, 50], style(color=0)),
          Line(points=[0, -67; 90, -67], style(color=10)),
          Text(
            extent=[31, -68; 68, -81],
            style(color=10),
            string="s"),
          Line(points=[-100, -67; 0, -67], style(color=10)),
          Polygon(points=[-39, -64; -29, -67; -39, -70; -39, -64], style(color=
                  10, fillColor=10)),
          Text(
            extent=[-77, -70; -43, -85],
            style(color=10),
            string="s_offset"),
          Line(points=[-100, -71; -100, -51], style(
              color=10,
              fillColor=10,
              fillPattern=1)),
          Line(points=[-30, -73; -30, -33], style(
              color=10,
              fillColor=10,
              fillPattern=1)),
          Line(points=[100, -70; 100, -30], style(
              color=10,
              fillColor=10,
              fillPattern=1)),
          Polygon(points=[90, -64; 100, -67; 90, -70; 90, -64], style(color=10,
                 fillColor=10)),
          Rectangle(extent=[-100, 50; -30, 60], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[-100, -60; -30, 50], style(pattern=0, fillColor=8)),

          Rectangle(extent=[-30, 40; 100, -40], style(color=0)),
          Rectangle(extent=[-30, -40; 100, 30], style(pattern=0, fillColor=8)),

          Rectangle(extent=[-30, 30; 100, 40], style(
              pattern=0,
              fillColor=0,
              fillPattern=1)),
          Rectangle(extent=[-100, 60; -30, -60], style(color=0)),
          Line(points=[100, -40; 100, -60]),
          Text(extent=[42, 91; 57, 76], string="f"),
          Line(points=[40, 75; 70, 75], style(color=3)),
          Polygon(points=[-21, 78; -31, 75; -21, 72; -21, 78], style(color=3,
                fillColor=3)),
          Line(points=[-8, 75; -31, 75], style(color=3)),
          Text(extent=[-21, 90; -6, 75], string="f"),
          Polygon(points=[60, 78; 70, 75; 60, 72; 60, 78], style(color=3,
                fillColor=3)),
          Line(points=[-30, 64; 70, 64], style(color=10)),
          Polygon(points=[60, 67; 70, 64; 60, 61; 60, 67], style(color=10,
                fillColor=10)),
          Text(
            extent=[0, 63; 37, 50],
            style(color=10),
            string="s"),
          Rectangle(extent=[100, 40; 90, 80], style(color=0, fillColor=8))),
        Documentation(info="<HTML>
<p>
Joint where frame_b is translated along axis n which is fixed in frame_a.
The two frames coincide when \"s + s_offset = 0\", where
\"s_offset\" is a parameter with a zero default
and \"s\" is the relative distance.
</p>
<p>
This variant of the prismatic joint is designed to work together
with a length constraint in a kinematic loop. This means that the
relative distance \"s\" of the joint is computed such that the
length constraint is fulfilled.
</p>
<p>
<b>Usually, this joint should not be used by a user of the MultiBody
library. It is only provided to built-up the MultiBody.Joints.Assemblies.JointXYZ
joints.</b>
</p>
</HTML>
"));

    protected
      SI.Position r_a[3]=position_a.signal
        "Position vector from frame_a to frame_a side of length constraint, resolved in frame_a of revolute joint";
      SI.Position r_b[3]=position_b.signal
        "Position vector from frame_b to frame_b side of length constraint, resolved in frame_b of revolute joint";
      Real rbra[3] "= rb - ra";
      Real B "Coefficient B of equation: s*s + B*s + C = 0";
      Real C "Coefficient C of equation: s*s + B*s + C = 0";
      Real k1 "Constant of quadratic equation solution";
      Real k2 "Constant of quadratic equation solution";
      Real k1a(start=1);
      Real k1b;

      parameter Integer ndim=if world.enableAnimation and animation then 1
           else 0;
      Visualizers.Advanced.Shape box[ndim](
        each shapeType="box",
        each color=boxColor,
        each length=if noEvent(abs(s + s_offset) > 1.e-6) then s + s_offset
             else 1.e-6,
        each width=boxWidth,
        each height=boxHeight,
        each lengthDirection=e,
        each widthDirection=boxWidthDirection,
        each r=frame_a.r_0,
        each R=frame_a.R);

      function selectBranch
        "Determine branch which is closest to initial angle=0"
        import Modelica.Math.*;
        input SI.Length L "Length of length constraint";
        input Real e[3]
          "Unit vector along axis of translation, resolved in frame_a (= same in frame_b)";
        input SI.Position d_guess
          "Select the configuration such that at initial time |d-d_guess| is minimal (d: distance between origin of frame_a and origin of frame_b)";
        input SI.Position r_a[3]
          "Position vector from frame_a to frame_a side of length constraint, resolved in frame_a of prismatic joint";
        input SI.Position r_b[3]
          "Position vector from frame_b to frame_b side of length constraint, resolved in frame_b of prismatic joint";
        output Boolean positiveBranch "Branch of the initial solution";
      protected
        Real rbra[3] "= rb - ra";
        Real B "Coefficient B of equation: d*d + B*d + C = 0";
        Real C "Coefficient C of equation: d*d + B*d + C = 0";
        Real k1 "Constant of quadratic equation solution";
        Real k2 "Constant of quadratic equation solution";
        Real d1 "solution 1 of quadratic equation";
        Real d2 "solution 2 of quadratic equation";
      algorithm
        /* The position vector r_rel from frame_a to frame_b of the length constraint
       element, resolved in frame_b of the prismatic joint (frame_a and frame_b
       of the prismatic joint are parallel to each other) is given by:
          r_rel = d*e + r_b - r_a
       The length constraint can therefore be formulated as:
          r_rel*r_rel = L*L
       with
          (d*e + r_b - r_a)*(d*e + r_b - r_a)
                   = d*d + 2*d*e*(r_b - r_a) + (r_b - r_a)*(r_b - r_a)
       follows
          (1)  0 = d*d + d*2*e*(r_b - r_a) + (r_b - r_a)*(r_b - r_a) - L*L
       The vectors r_a, r_b and parameter L are NOT a function of
       the distance d of the prismatic joint. Therefore, (1) is a quadratic
       equation in the single unknown "d":
          (2) d*d + B*d + C = 0
              with   B = 2*e*(r_b - r_a)
                     C = (r_b - r_a)*(r_b - r_a) - L*L
       The solution is
          (3) d = - B/2 +/- sqrt(B*B/4 - C)
    */
        rbra := r_b - r_a;
        B := 2*(e*rbra);
        C := rbra*rbra - L*L;
        k1 := B/2;
        k2 := sqrt(k1*k1 - C);
        d1 := -k1 + k2;
        d2 := -k1 - k2;
        if abs(d1 - d_guess) <= abs(d2 - d_guess) then
          positiveBranch := true;
        else
          positiveBranch := false;
        end if;
      end selectBranch;
      annotation (Diagram);
    initial equation
      positiveBranch = selectBranch(length, e, s_offset + s_guess, r_a, r_b);
    equation
      axis.f = f;
      axis.s = s;
      bearing.s = 0;
      distance = s_offset + s;

      // relationships of frame_a and frame_b quantities
      r_rel_a = e*distance;
      frame_b.r_0 = frame_a.r_0 + Frames.resolve1(frame_a.R, r_rel_a);
      frame_b.R = frame_a.R;
      zeros(3) = frame_a.f + frame_b.f;
      zeros(3) = frame_a.t + frame_b.t + cross(r_rel_a, frame_b.f);

      if axisForceBalance then
        /* Note, if axisForceBalance is false, the force in the
       length constraint must be calculated such that the driving
       force in direction of the translation axis is:
          axis.f = -e*frame_b.f;
       If axisForceBalance=true, this equation is provided here.
       As a consequence, the force in the length constraint will be
       part of a linear algebraic system of equations (otherwise, it
       might be possible to remove this force from the linear system).
    */
        f = -e*frame_b.f;
      end if;

      // Compute translational distance (details, see function "selectBranch")
      rbra = r_b - r_a;
      B = 2*(e*rbra);
      C = rbra*rbra - length*length;
      k1 = B/2;
      k1a = k1*k1 - C;
      assert(noEvent(k1a > 1.e-10), "
Singular position of loop (either no or two analytic solutions;
the mechanism has lost one-degree-of freedom in this position).
Try first to use another MultiBody.Joints.Assemblies.JointXXX component.
If this also lead to singular positions, it could be that this
kinematic loop cannot be solved analytically with a fixed state
selection. In this case you have to build up the loop with
basic joints (NO aggregation JointXXX components) and rely on
dynamic state selection, i.e., during simulation the states will
be dynamically selected in such a way that in no position a
degree of freedom is lost.
");
      k1b = Frames.Internal.maxWithoutEvent(k1a, 1.0e-12);
      k2 = sqrt(k1b);
      distance = -k1 + (if positiveBranch then k2 else -k2);
    end PrismaticWithLengthConstraint;
    annotation (Documentation(info="<HTML>
<p>
The models in this package should not be used by the user.
They are designed to build up other models in the MultiBody library
and some of them cannot be used in an arbitrary way and require
particular knowledge how to set the options in the parameter menu.
Don't use the models of this package.
</p>
</HTML>"));
  end Internal;

end Joints;
