package MultiBody "Library to model the movement of 3-dimensional mechanical systems"


annotation (
  version="1.0.1",
  versionDate="2004-07-07",
  conversion(
    from(version="0.96", script="Scripts/ConvertTo_0.98.mos"),
    from(version="0.97", script="Scripts/ConvertTo_0.98.mos"),
    from(version="0.98", script="Scripts/ConvertTo_1.0.mos"),
    from(version="0.99", script="Scripts/ConvertTo_1.0.mos"),
    from(version="0.99 Beta", script="Scripts/ConvertTo_1.0.mos"),
    noneFromVersion="1.0"),
  preferedView="info",
  Settings(NewStateSelection=true),
  Dymola(checkSum="3772349965:912913740"),
  Documentation(info="<HTML>
<p>
Library <b>MultiBody</b> is a <b>free</b> Modelica package providing
3-dimensional mechanical components to model in a convenient way
<b>mechanical systems</b>, such as robots, mechanisms, vehicles.
Typical animations generated with this library are shown
in the next figure:
</p>
<p>
<img src=\"../Images/MultiBody.png\">
</p>
<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"Modelica:MultiBody.UsersGuide\">MultiBody.UsersGuide</a>
     discusses the most important aspects how to use this library.</li>
<li> <a href=\"Modelica:MultiBody.Examples\">MultiBody.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>
<p>
The MultiBody library will be included as
Modelica.Mechanics.MultiBody in the next version of the
Modelica standard library.
Note, that the MultiBody library replaces the long used
ModelicaAdditions.MultiBody library. In
<a href=\"Modelica:MultiBody.UsersGuide.Upgrade\">MultiBody.UsersGuide.Upgrade</a>
it is described how to upgrade.
</p>
<p><b>Copyright &copy; 2003, Modelica Association and DLR.</b></p>
<p><i>
This Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> in the documentation of package
Modelica in file \"Modelica/package.mo\".
</i></p>
</HTML>"),
  uses(Modelica(version="1.6")));
import SI = Modelica.SIunits;


extends Modelica.Icons.Library;


package UsersGuide "User's Guide"
  annotation (DocumentationClass=true, Documentation(info="<HTML>
<h3><font color=\"#008000\" size=5>User's Guide of package MultiBody</font></h3>
<p>
Library <b>MultiBody</b> is a <b>free</b> Modelica package providing
3-dimensional mechanical components to model in a convenient way
<b>mechanical systems</b>, such as robots, mechanisms, vehicles.
This package contains the user's guide for the MultiBody library.
</p>

<ol>
<li>
<a href=\"Modelica:MultiBody.UsersGuide.Tutorial\">Tutorial</a>
gives an introduction into the most important aspects of the library.
</li>
<li>
<a href=\"Modelica:MultiBody.UsersGuide.Upgrade\">Upgrade</a> describes
  how to upgrade from former versions, especially from the \"old\"
  ModelicaAdditions.MultiBody library.
</li>
<li>
<a href=\"Modelica:MultiBody.UsersGuide.ReleaseNotes\">Release Notes</a>
  summarizes the differences between different versions of this
  library.
</li>
<li>
<a href=\"Modelica:MultiBody.UsersGuide.Literature\">Literature</a> provides
  references that have been used to design and implement this library.
</li>
<li>
<a href=\"Modelica:MultiBody.UsersGuide.Contact\">Contact</a> provides
  information about the author of the library as well as
  acknowledgments.
</li>
</ol>

</HTML>"));

  package Tutorial "Tutorial"
    annotation (DocumentationClass=true, Documentation(info="<HTML>
<h3><font color=\"#008000\" size=5>Tutorial</font></h3>
<p>
This tutorial provides an introduction into the
MultiBody library.
</p>

<ol>
<li>
<a href=\"Modelica:MultiBody.UsersGuide.Tutorial.OverView\">Overview of
MultiBody library</a> summarizes the most important aspects.
</li>
<li>
<a href=\"Modelica:MultiBody.UsersGuide.Tutorial.FirstExample\">A first example</a>
  describes in detail all the steps to build a simple pendulum model.
</li>
<li>
<a href=\"Modelica:MultiBody.UsersGuide.Tutorial.LoopStructures\">Loop structures</a>
  explains how to model kinematic loops, especially by analytically
  solving non-linear equations.
</li>
</ol>

</HTML>"));

    class OverView "Overview of MultiBody library"

      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Overview of MultiBody Library</font></h3>
<p>
Library <b>MultiBody</b> is a <b>free</b> Modelica package providing
3-dimensional mechanical components to model in a convenient way
<b>mechanical systems</b>, such as robots, mechanisms, vehicles.
A basic feature is that all components have <b>animation</b> information
with appropriate default sizes and colors. A typical screenshot of the
animation of a double pendulum is shown in the figure below, together
with its schematic.
</p>
<IMG SRC=\"../Images/Examples/Elementary/DoublePendulumSmall.png\"> &nbsp;&nbsp;
<IMG SRC=\"../Images/Tutorial/DoublePendulumDiagramSmall.png\"
  ALT=\"double pendulum (diagram layer)\">
<p>
Note, that all components - the coordinate system of the world frame,
the gravity acceleration vector, the revolute joints and the
bodies - are visualized in the animation.<br>
This library replaces the long available ModelicaAdditions.MultiBody
library, since it is much more easier to use and more powerful.
The main features of the library are:
</p>
<ul>
<li>About <b>60 main components</b>, i.e., joint, force, part,
    body, sensor and visualizer components that are ready to use
    and have useful default animation properties. One-dimensional
    force laws can be defined with components of the Modelica.Mechanics.Rotational
    and of the Modelica.Mechanics.Translational library and can be
    connected via available flange connectors to MultiBody
    components.
<li>About <b>75 functions</b> to operate in a convenient way on
    orientation objects, e.g., to transform vector quantities between
    frames, or compute the orientation object of a planar rotation.
    The basic idea is to hide the actual definition of an <b>orientation</b>
    by providing essentially an <b>Orientation</b> type together with
    <b>functions</b> operating on instances of this type. Orientation
    objects based on a 3x3 transformation matrix and on quaternions
    are provided. As a side effect, the equations in all other
    components are simpler and easier to understand.</li>
<li> <b>A World model</b> has to be present in every model on top
     level. Here the gravity field is defined (currently: no gravity,
     uniform gravity, point gravity), the visualization of the
     world coordinate system and default settings for animation.
     If a world model is not present, it is automatically provided
     together with a warning message.
<li><b>Built-in animation properties</b> of all components, such as
    joints, forces, bodies, sensors. This allows an easy visual
    check of the constructed model. Animation of every component
    can be switched off via a parameter. The animation of a complete
    system can be switched off via one parameter in the <b>world</b>
    model. If animation is switched off, all equations related
    to animation are removed from the generated code. This is especially
    important for real-time simulation.</li>
<li><b>Automatic handling of kinematic loops</b>.
    Components can be connected together in a nearly arbitrary fashion.
    It does not matter whether components are flipped. This does not
    influence the efficiency. If kinematic loop structures occur,
    this is automatically handeled in an efficient way by a new
    technique to transform a certain class of overdetermined sets of
    differential algebraic equations symbolically to a system where
    the number of equations and unknowns are the same (the user need
    <b>not</b> cut loops with special cut-joints to construct a
    tree-structure). </li>
<li><b>Automatic state selection from joints and bodies</b>.
    Most joints and all bodies have potential states. A Modelica
    translator, such as Dymola, will use the generalized coordinates
    of joints as states if possible. If this is not possible,
    states are selected from body coordinates. As a consequence,
    strange joints with 6 degrees of freedom are not necessary
    to define a body moving freely in space. An advanced user
    may select states manually from the <b>Advanced</b> menu of the
    corresponding components or use a Modelica parameter modification
    to set the \"stateSelect\" attribute directly. </li>
<li> <b>Analytic solution of kinematic loops</b>. The non-linear
    equations occuring in kinematic loops are solved <b>analytically</b>
    for a large class of mechanisms, such as a 4 bar mechanism,
    a slider-crank mechanism or a MacPherson suspension. This is performed
    by constructing such loops with assembly joints JointXXX,
    available in the MultiBody.Joints package. Assembly joints consist
    of 3 joints that have together 6 degrees of freedom, i.e., no
    constraints.They do not have potential states. When the motion
    of the two frame connectors are provided, a non-linear system of
    equation is solved analytically to compute the motion of the 3 joints.
    Analytic loop handling is especially important for real-time simulation.</li>
<li> <b>Line force components may have mass</b>.
     Masses of line force components are located on the line on which
     the force is acting. They approximate the mass properties of
     a real physical device by one or two point masses. For example,
     a spring has often significant mass that has to be taken into
     account. If masses are set to zero, the additional code to handle
     these point masses is removed. If the masses are taken into
     account, the calculation overhead is small (the reason is that
     the occuring kinematic loops are analytically solved).<br>
     Note, in this Beta-release, not all provided line force
     components have already an optional mass. This will be fixed
     in the next release.</li>
<li> <b>Force components may be connected directly together</b>, e.g.,
     3-dimensional springs in series connection. Usually,
     multi-body programs have the restriction that force components
     can only be connected between two bodies. Such restrictions are
     not present in the Modelica multi-body library, since it is
     a fully object-oriented, equation based library. Usually, if
     force components are connected directly together, non-linear
     systems of equations occur. The advantage is often, that this
     may avoid stiff systems that would occur if a small mass has
     to be put in between the two force elements.</li>
<li><b>Initialization definition is available via menus</b>.
    Initialization of states in joints and bodies can be
    performed in the parameter menu, <b>without</b> typing Modelica
    statements. For non-standard initialization, the usual
    Modelica commands can be used.</li>
<li><b>Multi-body specific error messages</b>. Annotations
    and assert statements have been introduced that provide
    in many cases warning or error messages that are related
    to the library components (and not to specific equations
    as it is usual in Modelica libraries). This requires
    appropriate tool support, as it is, e.g., available in Dymola.</li>
<li><b>Inverse models</b> of mechanical systems can be easily
    defined by using motion generators, e.g.,
    Modelica.Mechanics.Rotational.Position. Also, non-standard
    inverse models can be generated, e.g., when elasticity is present
    it might be necessary to differentiate equations several times.</li>
</ul>
</HTML>
"));
    end OverView;

    class FirstExample "A first example"

      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">A first example</font></h3>
<p>
As a first example it shall be demonstrated how to build up, simulate
and animate a <b>simple pendulum</b>.
</p>
<p>
A simple pendulum consisting of a <b>body</b> and a <b>revolute</b> joint
with <b>linear damping</b> in the joint, is first build-up as
Modelica composition diagram, resulting in:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/FirstExample/PenulumSchematic1.png\"
ALT=\"Modelica composition diagram of simple pendulum\">
</p>
<p>
In the following figure the location of the used
model components is shown. Drag these components in the diagram layer
and connect them according to the figure:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/FirstExample/PenulumSchematic2.png\">
</p>
<p>
Every model that uses model components from the MultiBody library
must have an instance of the MultiBody.World model on highest level.
The reason is that in the world object the gravity field is defined
(uniform gravity or point gravity), as well as the default sizes of
animation shapes and this information is reported to all used
components. If the World object is missing, a warning message is
printed and an instance of the World object with default settings is
automatically utilized (this feature is defined with annotations and
is, e.g., supported by Dymola).
</p>
<p>
In a second step the parameters of the dragged components need to be
defined. Some parameters are vectors that have to be defined with respect
to a local coordinate system of the corresponding component. The easiest
way to perform this is to define a <b>reference configuration</b> of your
multi-body model: In this configuration, the relative coordinates of
all joints are zero. This means that all coordinate systems on all
components are parallel to each other. Therefore, this just means
that all vectors are resolved in the world frame in this configuration.
</p>
<p>
The reference configuration for the simple pendulum shall be defined
in the following way: The y-axis of the world frame is directed
upwards, i.e., the opposite direction of the gravity acceleration.
The x-axis of the world frame is orthogonal to it. The revolute joint
is placed in the origin of the world frame. The rotation axis of the revolute
joint is directed along the z-axis of the world frame. The body is
placed on the x-axis of the world frame (i.e., the rotation angle of the
revolute joint is zero, when the body is on the x-axis).
In the following figures the definition of this reference configuration
is shown in the parameter menus of the revolute joint and the body:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/FirstExample/ActuatedRevolute.png\">
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/FirstExample/Body.png\">
</p>
<p>
Translate and simulate the model, e.g., with Dymola.
Automatically, all defined components are visualized in
an animation using default absolute or relative sizes
of the components. For example, a body is visualized as
a sphere and as a cylinder. The default size of the sphere is defined
as parameter in the world object. You may change this size
in the \"Animation\" parameter menu of the body (see parameter menu
above). The default size of the cylinder is defined relatively
to the size of the sphere (half of the sphere size).
With default settings, the following animation is defined:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/FirstExample/Pendulum.png\">
</p>
<p>
The world coordinate system is visualized as coordinate system
with axes labels. The direction of the gravity acceleration
vector is shown as green arrow. The red cylinder represents
the rotation axis of the revolute joint and the light blue
shapes represent the body. The center of mass of the body is
in the middle of the light blue sphere.
</p>
</HTML>
"));
    end FirstExample;

    package LoopStructures "Loop structures"

      class Introduction "Introduction"

        annotation (DocumentationClass=true, Documentation(info="<HTML>
<h3><font color=\"#008000\">Introduction</font></h3>
<p>
In principal, now special action is needed, if
loop structures occur (contrary to the ModelicaAdditions.MultiBody library).
An example is presented in the figure below. It is available as
<a href=\"Modelica://MultiBody.Examples.Loops.Fourbar1\">
MultiBody.Examples.Loops.Fourbar1</a>
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/LoopStructures/Fourbar1a.png\">
</p>
<p>
This mechanism consists of 6 revolute joints, 1 prismatic joint and forms a
kinematical loop.
It has has one degree of freedom. In the next figure the default animation
is shown. Note, that the axes of the revolute joints are represented by the
red cylinders and that the axis of the prismatic joint is represented by the
red box on the lower right side.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/LoopStructures/Fourbar1b.png\" width=\"205\" height=\"107\">
</p>
<p>
Whenever loop structures occur, non-linear algebraic
equations are present on \"position level\". It is then usually not possible by
structural analysis to select states during translation (which is possible for
non-loop structures). In the example above, Dymola detects a non-linear
algebraic loop of 57 equations and reduces this to a system of 7 coupled
algebraic equations. Note, that this is performed without using any
\"cut-joints\" as it is usually done in multi-body programs, but by just
appropriate symbolic equation manipulation. Via the dynamic dummy derivative
method the generalized coordinates on position and velocity level from one of
the 7 joints are dynamically selected as states during simulation. Whenever,
these two states are no longer appropriate, states from one of the other
joints are selected during simulation.
</p>
<p>
The efficiency of loop structures can usually be
enhanced, if states are statically fixed at translation time. For this
mechanism, the generalized coordinates of joint j1 (i.e., the
rotation angle of the revolute joint and its derivative) can always be used as
states. This can be stated by setting parameter \"enforceStates = <b>true</b>\"
in the \"Advanced\" menu of the desired joint. This flag sets the attribute
stateSelect of the generalized coordinates of the coresponding joint to
\"StateSelect.always\". When setting this flag to <b>true</b> for joint j1 in
the four bar mechanism, Dymola detects a non-linear algebraic loop of 40
equations and reduces this to a system of 5 coupled non-linear algebraic
equations.
</p>
<p>
In many mechanisms it is possible to solve the non-linear algebraic
equations analytically. For a certain class of systems this can
be performed also with the MultiBody library. This technique
is described in section
\"<a href=\"AnalyticLoopHandling\">Analytic loop handling</a>\".
</p>
</HTML>"));
      end Introduction;

      class PlanarLoops "Planar loops"

        annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Planar Loops</font></h3>
<p>
In the figure below, the model of a V6 engine is
shown that has a simple combustion model. It is available as
<a href=\"Modelica://MultiBody.Examples.Loops.EngineV6\">
MultiBody.Examples.Loops.EngineV6</a>.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/LoopStructures/EngineV6_1.png\">
</p>
<p>
The Modelica schematic of one cylinder
is given in the figure below. Connecting 6 instances of this
cylinder appropriately together results in the engine schematic displayed
above.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/LoopStructures/EngineV6_2.png\">
</p>
<p>
In the next figure the animation of the engine is
shown. Every cylinder consists essentially of 1 prismatic and 2 revolute
joints that form a planar loop, since the axes of the two revolute joints are
parallel to each other and the axis of the prismatic joint is orthogonal to
the revolute joint axes. All 6 cylinders together form a coupled set of 6
loops that have together 1 degree of freedom.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/LoopStructures/EngineV6_3.png\" width=\"303\" height=\"136\">
</p>
<p>
All planar loops, and especially the engine, result in
a DAE (= Differential-Algebraic Equation system)
that does not have a unique solution. The reason is that, e.g., the cut
forces in direction of the axes of the revolute joints cannot be uniquely
computed. Any value fulfills the DAE equations. This is a structural property
that is determined by the symbolic algorithms. Since they detect that the DAE is
structurally singular, a further processing is not possible. Without
additional information it is also impossible that the symbolic algorithms
could be enhanced because if the axes of rotations of the revolute joints are
only slightly changed such that they are no longer parallel to each other, the
planar loop can no longer move and has 0 degrees of freedom. Algorithms based
on pure structural information cannot distinguish these two cases.
</p>
<p>
The usual remedy is to remove superfluous constraints,
e.g., along the axis of rotation of <b>one</b> revolute joint. Since this is
not easy for an inexperienced modeler, the flag \"<b>planarCutJoint</b>\" is provided
in the \"<b>Advanced</b>\" menu of a revolute joint that removes these constraints.
This flag must be set to <b>true</b> for one revolute joint in every planar
loop. In the engine example, this flag is set in the revolute joint B2 in the
cylinder model.
</p>
<p>
If a modeler is not aware of the problems with planar
loops and models them without special consideration, a Modelica
translator, such as Dymola, displays an error
message and points out that a planar loop may be the reason and suggests to
use the \"planarCutJoint\" flag. This error message is due to an annotation in
the Frame connector.
</p>
<pre>
  <b>connector</b> Frame
     ...
     <b>flow</b> SI.Force f[3] <b>annotation</b>(unassignedMessage=\"..\");
  <b>end</b> Frame;
</pre>
<p>
If no assignment can be found for some
forces in a connector, the \"unassignedMessage\" is displayed. In most cases the
reason for this is a planar loop or two joints that constrain the same motion.
Both cases are discussed in the error message.
</p>
<p>
Note, that the non-linear algebraic equations occurring
in planar loops can be solved analytically in most cases and therefore it is
highly recommended to use the techniques discussed in section
\"<a href=\"AnalyticLoopHandling\">Analytic loop handling</a>\"
for such systems.
</p>
</HTML>"));
      end PlanarLoops;

      class AnalyticLoopHandling "Analytic loop handling"

        annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Analytic loop handling</font></h3>
It is well known that the non-linear
algebraic equations of most mechanical loops in technical devices can be
solved analytically. It is, however, difficult to perform this fully
automatically and therefore none of the commercial, general purpose multi-body
programs, such as MSC ADAMS, LMS DADS, SIMPACK, have this feature.
These programs solve loop structures with pure numerical methods. Multi-body
programs that are designed for real-time simulation of the dynamics of
specific vehicles, such as ve-DYNA, usually contain manual implementations
of a particular multi-body system (the vehicle) where the occurring loops are
either analytically solved, if this is possible, or are treated by table
look-up where the tables are constructed in a pre-processing phase. Without
these features the required real-time capability would be difficult to
achieve.
</p>
<p>
In a series of papers and dissertations
Prof. Hiller and his group in Duisburg, Germany,
have developed systematic methods to handle mechanical
loops analytically. The \"characteristic pair of joints\" method
basically cuts a loop at two joints and uses geometric
invariants to reduce the number of algebraic
equations, often down to one equation that can be solved analytically. Also
several multi-body codes have been developed that are based on this method,
e.g., MOBILE. Besides the very desired feature to solve non-linear
algebraic equations analytically, i.e., efficiently and in a robust way, there
are several drawbacks: It is difficult to apply this method automatically.
Even if this would be possible in a good way, there is always the problem that
it cannot be guaranteed that the statically selected states lead to no
singularity during simulation. Therefore, the \"characteristic pair of joints\"
method is usually manually applied which requires know-how and experience.
</p>
<p>
In the MultiBody library the \"characteristic pair of
joints\" method is supported in a restricted form such that it can be applied
also by non-specialists. The idea is to provide aggregations of joints in package
<a href=\"Modelica://MultiBody.Joints.Assemblies\">
MultiBody.Joints.Assemblies</a>.
as one object that either have <b>6</b> degrees of freedom or
<b>3</b> degrees of freedom (for usage in planar loops).
</p>
<p>
As an example, a variant of the four bar mechanism is given in
the figure below.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/LoopStructures/FourbarAnalytic1.png\">
</p>
<p>
Here, the mechanism is modeled with one revolute
joint, two spherical joints and one prismatic joint.
In the figure below, the two spherical joints
and the prismatic joint are collected together in an assembly object
called \"jointSSP\" from
<a href=\"Modelica://MultiBody.Joints.Assemblies.JointSSP\">
MultiBody.Joints.Assemblies.JointSSP</a>.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/LoopStructures/FourbarAnalytic2.png\">
</p>
<p>
The JointSSP joint aggregation has a frame at the
left side of the left spherical joint (frame_a) and a frame at the right side
of the prismatic joint (frame_b). JointSSP, as all other objects from the
Joints.Assemblies package, has the property, that the <b>generalized
coordinates, and all other frames
defined in the assembly, can be calculated given the movement of frame_a and
of frame_b</b>. This is performed by <b>analytically</b> solving non-linear
systems of equations (details are given in section xxx). From a
structural point of view, the equations in an assembly object are written in
the form
</p>
<p align=\"center\">
  <b>q</b> = <b>
  f</b><sub>1</sub>(<b>r</b><sup>a</sup>, <b>R</b><sup>a</sup>,<b> r</b><sup>b</sup>,
  <b>R</b><sup>b</sup>)
</p>
<p>
where<b> r</b><sup>a</sup>, <b>R</b><sup>a</sup>,<b>
r</b><sup>b</sup>, <b>R</b><sup>b</sup><b> </b>are the variables defining the
position and orientation of the frame_a and frame_b connector,
<b>q</b> are the generalized positional coordinates inside the
assembly, e.g., the angle of a revolute joint. Given angle
<span style=\"font-family:Symbol\">j</span> of revolute joint j1 from the four
bar mechanism, frame_a and frame_b of the assembly object can be computed by a
forward recursion
</p>
<p align=\"center\">
(<b>r</b><sup>a</sup>,
<b>R</b><sup>a</sup>,<b> r</b><sup>b</sup>, <b>R</b><sup>b</sup>) = <b>f</b>(<span style=\"font-family:Symbol\">j)</span>
</p>
<p>
Since this is a structural property, the
symbolic algorithms can automatically select <span style=\"font-family:Symbol\">
j</span> and its derivative as states and then all positional variables can be
computed in a forwards sequence. It is now understandable that a Modelica
translator, such as Dymola, can
transform the equations of the four bar mechanism to a recursive sequence of
statements that has no non-linear algebraic loops anymore(remember,
the previous \"straightforward\" solution with 6 revolute joints and 1
prismatic joint has a nonlinear system of equations of order 5).
</p>
<p>
The aggregated joint
objects consist of a combination of either a revolute or prismatic joint and
of a rod that has either two spherical joints at its two ends or a spherical
and a universal joint, respectively. For all combinations, analytic solutions
can be determined. For planar loops, combinations of 1, 2 or 3 revolute joints
with parallel axes and of 2 or 1 prismatic joint with axes that are orthogonal
to the revolute joints can be treated analytically. The currently supported
combinations are listed in the table below.
The missing combinations (such as JointSUP
or Joint RPP) will be added in one of the next releases.
</p>
<div align=\"center\">
    <table border=\"1\" cellspacing=\"0\" cellpadding=\"0\">
      <tr>
        <td colspan=\"2\"> <b>3-dimensional Loops:</b></td>
      </tr>
      <tr>
        <td>JointSSR</td>
        <td>Spherical - Spherical - Revolute</td>
      </tr>
      <tr>
        <td>JointSSP</td>
        <td>Spherical - Spherical - Prismatic</td>
      </tr>
      <tr>
        <td>JointUSR</td>
        <td>Universal - Spherical - Revolute</td>
      </tr>
      <tr>
        <td>JointUSP</td>
        <td>Universal - Spherical - Prismatic</td>
      </tr>
      <tr>
        <td>JointUPS</td>
        <td>Universal - Prismatic - Spherical</td>
      </tr>
      <tr>
        <td colspan=\"2\"><b>Planar Loops:</b></td>
      </tr>
      <tr>
        <td>JointRRR</td>
        <td>Revolute - Revolute - Revolute</td>
      </tr>
      <tr>
        <td>JointRRP</td>
        <td>Revolute - Revolute - Prismatic</td>
      </tr>
</table>
</div>
<p>
On first view this seems to be quite restrictive. However, mechanical devices are usually built up with rods connected by spherical joints on each end,
and additionally with revolute and prismatic joints.
Therefore, the combinations of the above table occur frequently.
The universal joint is usually not present in actual devices but is used
(a) if two JointXXX components can be connected such that a revolute
and a universal joint together form a spherical joint
and (b) if the orientation of the connecting rod between two
spherical joints is needed, e.g., since a body shall be attached.
In this case one of the spherical joints might be replaced by a
universal joint. This approximation is fine as long as the mass
and inertia of the rod is not significant.
</p>
<p>
Let us discuss item (a) in more detail: The
MacPherson suspension in the next figure
is from the Modelica VehicleDynamics library.
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/LoopStructures/MacPherson1.png\">
</p>
It has three frame
connectors. The lower left one (frame_C) is fixed in the vehicle chassis. The
upper left one (frame_S) is driven by the steering mechanism, i.e., the
movement of both frames are given. The frame connector on the right (frame_U)
drives the wheel. The three frames are connected by a mechanism consisting
essentially of two rods with spherical joints on both ends. These are built up
by a jointUPS and a jointSSR assembly.
As can be seen, the universal joint from the jointUPS
assembly is connected to the revolute joint of the jointSSR assembly.
Therefore, we have 3 revolute joints connected together at one point and if
the axes of rotations are chosen appropriately, this describes a spherical
joint. In other words, the two connected assemblies define the desired two
rods with spherical joints on each ends.
</p>
<p>
The movement of the chassis, frame_C, is computed
somewhere else. When the generalized coordinates of revolute joint
\"innerJoint\" (lower left part in figure) are used as states, then frame_a and
frame_b of the jointUPS joint can be calculated. After the non-linear loop
with jointUPS is (analytically) solved, all frames on this assembly are
known, especially,
the one connected to frame_b of the jointSSR assembly. Since frame_b of
jointSSR is connected to frame_S which is computed from the steering
mechanism, again the two required frame movements of the jointSSR assembly are
calculated, meaning in turn that also all other frames on the jointSSR
assembly can be computed, especially, the one connected to frame_U that drives
the wheel. From this analysis it is clear that a tool is able to solve these
coupled loops analytically.
</p>
<p>
Another example is the model of the V6 engine,
see next figure for an animation view and the original definition
of one cylinder with elementary joints.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/LoopStructures/EngineV6_3.png\" width=\"303\" height=\"136\">
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/LoopStructures/EngineV6_2.png\">
</p>

<p>
It is sufficient to rewrite the basic cylinder model
by replacing the joints with a JointRRP object that has two
revolute and one prismatic joint, see next figure.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/LoopStructures/EngineV6_4.png\">
</p>
<p>
Since 6
cylinders are connected together, 6 coupled loops with 6 JointRRP objects are
present. This model is available as
<a href=\"Modelica://MultiBody.Examples.Loops.Engine�V6_analytic\">
MultiBody.Examples.Loops.Engine�V6_analytic</a>.
</p>
<p>
The composition diagram of the connected 6 cylinders is
shown in the next figure
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Tutorial/LoopStructures/EngineV6_1.png\">
</p>
<p>
It can be seen that the revolute joint
of the crank shaft (joint \"bearing\" in left part of figure) might be
selected as degree of freedom. Then the 4 connector frames of all cylinders
can be computed. As a result the computations of the cylinders are decoupled
from each other. Within one cylinder
the position of frame_a and frame_b of the jointRRP assembly
can be computed and therefore the generalized coordinates of the two revolute
and the prismatic joint in the jointRRP object can be determined. From this
analysis it is not surprising that a Modelica translator, such as Dymola,
is able to transform the DAE
equations into a sequential evaluation without any non-linear loop.
Compare this nice result with the model using only elementary joints
that leads to a DAE with 6 algebraic loops and 5 non-linear equations per
loop. Additionally, a linear system of equations of order 43 is present.
The simulation time is about 5 times faster with the analytic loop handling.
</p>
</HTML>
"));
      end AnalyticLoopHandling;
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Loop structures</font></h3>
<p>
The MultiBody library has the feature that all components
can be connected together in a nearly arbitrary fashion.
Therefore, kinematic loop structures pose in principal
no problems. In this section several examples are given,
the special treatment of planar loops is discussed and it is explained
how a kinematic loop structure can be modeled such that the
occuring non-linear algebraic equation systems are solved
analytically. There are the following sub-chapters:
</p>

<ol>
<li>
<a href=\"Modelica:MultiBody.UsersGuide.Tutorial.LoopStructures.Introduction\">Introduction</a>
</li>
<li>
<a href=\"Modelica:MultiBody.UsersGuide.Tutorial.LoopStructures.PlanarLoops\">Planar loops</a>.
</li>
<li>
<a href=\"Modelica:MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling\">Analytic loop handling</a>.
</li>
</ol>
</HTML>"));
    end LoopStructures;
  end Tutorial;

  class Upgrade "Upgrade from Former Versions"
    annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\" size=5>Upgrade from Former Versions</font></h3>

<p>
If different versions of the MultiBody library are not
compatible to each other, corresponding conversion scripts are
provided. As a result, models build with an older version
of the MultiBody library are automatically converted to the
new version when the model is loaded. The user is prompted
whether automatic conversion shall take place or not.
Problems are not to be expected. Still one should first make
a copy of such a model as backup before the conversion
is performed.
</p>

<p>
<b><font color=\"#008000\">Upgrade from ModelicaAdditions.MultiBody</font></b>
</p>

<p>
There is now also a conversion script from the \"old\"
<b>ModelicaAdditions.MultiBody</b> library to the
\"new\" MultiBody library. This script is not automatically
invoked. Since the differences between the \"old\" and the
\"new\" MultiBody library are so large, not everything is
converted and it might be that some pieces have to
be adapted manually. Still, this script is useful, since
many class names, parameters and modifiers are
automatically converted. Invoke this script in the following way:
</p>

<ol>
<li> Make a backup copy of the model that you want to convert.</li>
<li> Start a fresh Dymola. </li>
<li> Change to \"Simulation\" window and click on
     \"Simulation / Run Script\"</li>
<li> Select \"<b>MultiBody/Scripts/ConvertOldToNewMultiBody.mos</b>\"</li>
<li> Change to \"Modeling\" window and open the desired model.
     When opening the model, it is automatically converted.</li>
<li> Select the model in the \"Packages\" browser and click on
     \"File / Save\" to save the converted model under the
     same name.</li>
</ol>

<p>
Currently, components from the following sublibraries
are automatically converted
to the \"new\" MultiBody library:
</p>

<ul>
<li> ModelicaAdditions.MultiBody.Parts</li>
<li> ModelicaAdditions.MultiBody.Joints</li>
<li> ModelicaAdditions.MultiBody.Forces</li>
<li> Part of ModelicaAdditions.MultiBody.Interfaces</li>
</ul>

<p>
Models using the ModelicaAdditions.MultiBody library
that are programmed with <b>equations</b> are only partly converted:
The Frame connectors will be converted to the \"new\"
Frame connectors of the MultiBody library, but the equations
that reference variables of the Frame connectors will
<b>not</b> be converted. For a manual conversion, the following
table might be helpful showing how the <b>variables</b> of the
\"old\" and the \"new\" <b>Frame connectors</b> are
related to each other (resolve2 and angularVelocity2 are
functions from library MultiBody.Frames):
</p>

<table border=1 cellspacing=0 cellpadding=2>
<tr><th><b>ModelicaAdditions.MultiBody.<br>
           Interfaces.Frame_a</b></th>
    <th><b>MultiBody.Interfaces.Frame_a</b></th></tr>
<tr>
  <td>frame_a.<b>r0</b></td>
  <td>= frame_a.r_0 (is converted)</td>
</tr>

<tr>
  <td>frame_a.<b>S</b></td>
  <td>= transpose(frame_a.R)</td>
</tr>

<tr>
  <td>frame_a.<b>v</b></td>
  <td>= resolve2(frame_a.R, <b>der</b>(frame_a.r_0))</td>
</tr>

<tr>
  <td>frame_a.<b>w</b></td>
  <td>= angularVelocity2(frame_a.R)</td>
</tr>

<tr>
  <td>frame_a.<b>a</b></td>
  <td>= resolve2(frame_a.R, <b>der</b>(v_0)); v_0 = der(r_0)</td>
</tr>

<tr>
  <td>frame_a.<b>z</b></td>
  <td>= <b>der</b>(w);  w = angulaVelocity2(frame_a.R)</td>
</tr>

<tr>
  <td>frame_a.<b>f</b></td>
  <td>= frame_a.f (no conversion needed)</td>
</tr>

<tr>
  <td>frame_a.<b>t</b></td>
  <td>= frame_a.t (no conversion needed)</td>
</tr>

</table>

</HTML>
"));
  equation

  end Upgrade;

  class ReleaseNotes "Release notes"

    annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\" size=5>Release notes</font></h3>

<h3><font color=\"#008000\">Version 1.0.1, 2004-07-07</font></h3>
<p>
This version fixes only some minor bugs:
</p>

<ul>
<li> Bug in MultiBody.Sensors.<b>RelativeSensor</b> fixed:<br>
     When frame resolve was connected and get_v_rel=true or
     get_a_rel=true, an error was in the code</li>.
<li> Bug in MultiBodys.Sensors.<b>Power</b> fixed:<br>
     A \"defineBranch(...)\" statement was missing. In certain cases,
     it was then not possible to generate code</li>.
<li> Wrong icon of MultiBody and of MultiBody.Interfaces package
     corrected.</li>
</ul>

<h3><font color=\"#008000\">Version 1.0, 2004-03-03</font></h3>
<p>
This version is <b>not</b> backward compatible to version 0.99.
Models generated with previous MultiBody versions are automatically
converted to the new release.The incompatible changes are due
to improving the efficiency of the library. This required
to change function interfaces in MultiBody.Frames: angularVelocity1,
angularVelocity2, planarRotation, axisRotation, axesRotations, from_T,
from_T_inv, from_Q. Furthermore, MultiBody.Frames.Orientation has changed.
As a consequence, all code that accesses objects of this type
directly is no longer valid. Otherwise, the following changes have been made:
</p>

<ul>
<li> <b>Faster code</b>:<br>
     Due to a different strategy to handle orientation objects,
     the number of arithmetic expressions in the generated code is
     reduced (for larger models there is a speed-up of about 2-3).</li>

<li> Improved <b>documentation</b>:<br>
     Tutorial renamed to \"User's Guide\" and documents restructured
     and improved. Included 3-dimensional images for nearly every
     component description where it makes sense. Improved the
     documentation of the packages.</li>

<li> New package MultiBody.Frames.<b>TransformationMatrices</b>:<br>
     This is a copy of the previous MultiBody.Frames.XX functions.
     The new MultiBody.Frames.XX functions have a different orientation
     object that can no longer be directly used, since the angular
     velocity calculation is implicitly included in the functions
     to improve efficiency significantly</li>

<li> New function MultiBody.Frames.<b>resolveRelative</b>:<br>
     Transform vector from frame 1 to frame 2 using absolute
     orientation objects of frame 1 and of frame 2.</li>

<li> Improved handling of orientation in MultiBody.Joints.<b>Spherical</b>,
     MultiBody.Joints.<b>FreeMotion</b>, MultiBody.Parts.<b>Body</b>:<br>
     If states are used from these components, the orientation is either
     described by quaternions or by 3 angles along desired sequence
     axes. If 3 angles are used, the code is such that symbolic
     transformation methods for inline integration can generate efficient
     code. In \"Spherical\" and \"Body\" the switching between different
     sets of 3 angles has been removed since this may lead to difficulties
     for the symbolic transformations. In \"FreeMotion\" the option to
     use quaternions has been added.</li>

<li> New option for \"MultiBody.Sensors.<b>AbsoluteSensor</b>\":<br>
     Optionally, the angles to rotate the world frame into frame_a
     are returned.</li>

<li> New option for \"MultiBody.Sensors.<b>RelativeSensor</b>\":<br>
     Optionally, the angles to rotate frame_a into frame_b
     are returned.</li>

<li> Improved \"MultiBody.Examples.Loops.<b>EngineV6_analytic</b>\":<br>
     Model restructured and animated with CAD data.</li>

<li> <b>Specular coefficient</b> introduced with default 0.7:<br>
     The components in Visualizers.Advanced have as additional
     input the specular coefficient describing the reflection
     of ambient light. The default is 0.7. Coordinate systems
     have a specular coefficient of 0 (= light is not reflected).
     </li>

<li> Improved MultiBody.Frames.<b>Frame_resolve</b>:<br>
     The frame outline is with a full line. When drawing a
     connection line from Frame_resolve to another frame,
     this connection line is dotted.</li>
</ul>


<h3><font color=\"#008000\">Version 0.99, 2004-02-16</font></h3>
<p>
This version is <b>fully</b> backward compatible to version 0.98.
The following changes have been made:
</p>

<ul>
<li> New options for \"MultiBody.Joints.<b>Spherical</b>\".<br>
     This joint may have optionally Cardan angles or quaternions
     as states. Additionally, an \"Initialization\" tab has been
     added in order that the relative coordinates of the joint
     can be used for initialization.</li>
<li> New model \"MultiBody.Joints.<b>GearConstraint</b>\"<br>
     to model the 3D constraint of a gear box.</li>
<li> New model \"MultiBody.Parts.<b>Mounting1D</b>\" <br>
     to propagate 1D support torques to a 3D mounting.</li>
<li> New model \"MultiBody.Parts.<b>Rotor1D</b>\" <br>
     to attach a 1D inertia on 3D mountings without
     neglecting dynamic effects.</li>
<li> New model \"MultiBody.Parts.<b>BevelGear1D</b>\" <br>
     that describes a 1D gearbox with arbitrary shaft
     directions and that is attached on a 3D mounting.</li>
<li> New package \"MultiBody.Examples.Systems.<b>RobotR3</b>\".<br>
     The models of this package are used to demonstrate in which
     way complex robot models might be built up by testing first
     the component models individually before composing them together.
     Furthermore, it is shown how CAD data can be used for animation.
<li> New model \"MultiBody.Sensors.<b>AbsoluteSensor</b>\"<br>
     to provide kinematic quantities of a frame as output signals
     resolved in the local frame, in the world frame or in a frame that
     is connected to the AbsoluteSensor object via connector frame_resolve.</li>
<li> New model \"MultiBody.<b>Sensors.Distance</b>\"<br>
     to provide the distance between frame_a and frame_b as output signal.
     Derivatives of the distance can be easily obtained by connecting
     block Modelica.Blocks.Continuous.Der to the outPort.</li>
<li> New models \"MultiBody.<b>Sensors.Force/.Torque/.ForceAndTorque</b>\"<br>
     to provide cut forces and cut torques between two frames
     as output signals resolved in the local frame, in the world frame
     or in a frame that is connected to the objects
     via connector frame_resolve.</li>
<li> Improved model \"MultiBody.<b>Sensors.RelativeSensor</b>\"<br>
     A \"frame_resolve\" connector has been added, in order that the
     measured kinematic quantities can be resolved in the frame
     that is connected to frame_resolve.</li>
<li> New connector \"MultiBody.Interfaces.<b>Frame_resolve</b>\"<br>
     that should be used, if a frame provides solely orientation
     information.
     This connector is identical to the connectors \"Frame\", Frame_a\" and
     \"Frame_b\". Only the icon is different: The border line is dotted
     with default line width and not with double default line width as
     for the other frames. When drawing a connection, the connection
     line is usually by default using the line style of the connector.
     As a result, the connection line will be a thin, dotted line.
     Frame_resolve is now used in all components where the orientation
     of another frame is needed (e.g., in MultiBody.Forces.Force to
     define in which frame the force is provided).</li>
<li> New function \"MultiBody.Frames.<b>AngularVelocity1</b>\"<br>
     to compute the angular velocity of frame 2 with respect to frame 1
     resolved in frame 1 (previously, only function AngularVelocity2
     was provided to resolve the angular velocity in frame 2. Transforming
     this vector in to frame 1 is less efficient as directly computing
     the angular velocity resolved in frame 1).</li>
<li> New conversion script \"MultiBody\\Scripts\\<b>ConvertOldToNewMultiBody.mos</b>\"<br>
     to convert models from the \"old\" ModelicaAdditions.MultiBody
     library to the \"new\" MultiBody\" library. For details, see
     <a href=\"Modelica:MultiBody.UsersGuide.Upgrade\">
      MultiBody.UsersGuide.Upgrade</a>.</li>
</ul>
<h3><font color=\"#008000\">Version 0.98, 2003-10-27</font></h3>
<p>
This version is <b>not backward</b> compatible to the previous
MultiBody versions, since the initialization has changed.
Parameter \"startValuesFixed\" is no longer present and is
replaced by parameter \"initType\" (see below). Models generated with
previous MultiBody versions are automatically converted to the new
release.
</p>

<ul>
<li> <b>Tutorial</b> improved.</li>
<li> New model \"MultiBody.Joints.Assemblies.<b>JointSSP</b>\"<br>
     Spherical - spherical - prismatic joint aggregation with mass
     (no constraints, no potential states) for analytic loop handling.</li>
<li> New model \"MultiBody.Forces.<b>LineForceWithTwoMasses</b>\"<br>
     General line force component with two optional point masses on
     the connection line.</li>
<li> New model \"MultiBody.Forces.<b>Force</b>\"<br>
     Force acting between two frames, defined by 3 input signals
     and resolved in frame_b or in frame_resolve.</li>
<li> New model \"MultiBody.Forces.<b>Torque</b>\" <br>
     Torque acting between two frames, defined by 3 input signals
     and resolved in frame_b or in frame_resolve</li>
<li> New model \"MultiBody.Forces.<b>ForceAndTorque</b>\" <br>
     Force and torque acting between two frames, defined by
     6 input signals and resolved in frame_b or in frame_resolve.</li>
<li> New model \"MultiBody.<b>Examples.ForceAndTorque</b>\" <br>
     Demonstrate usage of ForceAndTorque element.</li>
<li> New model \"MultiBody.<b>Examples.LineForceWithTwoMasses</b>\"<br>
     Demonstrate line force with two point masses using a
     JointUPS and alternatively a LineForceWithTwoMasses component.</li>
<li> New model \"MultiBody.<b>Examples.InitSpringConstant</b>\"<br>
     Determine spring constant such that system is in steady
     state at given position.</li>
<li> Removed model \"MultiBody.Examples.ForceWithMass\"<br>
     This demo is included in the new LineForceWithTwoMasses
     example.</li>
<li> Change in \"MultiBody.Parts.<b>Body</b>\"<br>
     The default of parameter \"useQuaternions\" in the
     \"Advanced\" menu is changed from false to true.
     This means that by default quaternions are used as
     body states.</li>
<li> Change in all models that have potential states:<br>
     <b>New initialization</b> introduced replacing the previous
     \"startValuesFixed\" parameter. The new parameter \"initType\"
     can have the following values:
<pre>
 initType = MultiBody.Types.Init
  .Free                        : no initialization
                                 (= same as previous startValuesFixed = <b>false</b>)
  .PositionVelocity            : initialize generalized position and velocity variables
                                 (= same as previous startValuesFixed = <b>true</b>)
  .SteadyState                 : initialize in steady state
                                 (velocity and acceleration are zero)
  .Position                    : initialize only generalized position variable(s)
  .Velocity                    : initialize only generalized velocity variable(s)
  .VelocityAcceleration        : initialize generalized velocity and
                                 acceleration variables
  .PositionVelocityAcceleration: initialize generalized position, velocity
                                 and acceleration variables
</pre>
</li>
</ul>
<h3><font color=\"#008000\">Version 0.97, 2003-09-10</font></h3>
<p>
Bug fixed in model \"MultiBody.Parts.Body\": There was an
error when switching
from one set of Cardan angles to another one when the actual
Cardan angles are close to their singularity.
This has been corrected.
</p>
<h3><font color=\"#008000\">Version 0.96, 2003-08-04</font></h3>
<p>
This was the first version delivered with Dymola.
</p>
</HTML>
"));
  equation

  end ReleaseNotes;

  class Literature "Literature"

    annotation (Documentation(info="<html>

<h3><font color=\"#008000\" size=5>Literature</font></h3>

<ul>
<li>
Technical details of this library are described in the
20 page paper:

<dl>
<dt>Otter M., Elmqvist H., and Mattsson S.E.:</dt>
<dd> <b>The New Modelica MultiBody Library</b>.
     Modelica 2003 Conference, Link&ouml;ping, Sweden,
     pp. 311-330, Nov. 3-4, 2003.
     Download from:
     <a href=\"http://www.modelica.org/Conference2003/papers/h37_Otter_multibody.pdf\">http://www.modelica.org/Conference2003/papers/h37_Otter_multibody.pdf</a>
     </dd>
</dl>
</li>

<li>
The method how to describe drive trains with 1-dimensional mechanics
and to mount them on 3-dimensional components without neglecting
dynamical effects is described in:

<dl>
<dt>Schweiger C., and Otter M.:</dt>
<dd> <b>Modelling 3D Mechanical Effects of 1D Powertrains</b>.
     Modelica 2003 Conference, Link&ouml;ping, Sweden,
     pp. 149-158, Nov. 3-4, 2003.
     Download from:
<a href=\"http://www.modelica.org/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf\">http://www.modelica.org/Conference2003/papers/h06_Schweiger_powertrains_v5.pdf</a>
     </dd>
</dl>
</li>

<li> The method to solve a certain class of kinematic loops
     analytically is based on:
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
</li>

</ul>
</html>
"));
  end Literature;

  class Contact "Contact"

    annotation (Documentation(info="<html>

<h3><font color=\"#008000\" size=5>Contact</font></h3>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik<br>
    Abteilung f&uuml;r Entwurfsorientierte Regelungstechnik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<p><b>Acknowledgements:</b></p>
<ul>
<li> The central idea to handle a certain class of overdetermined, consistent
     set of differential algebraic equations (i.e., there are more equations than
     unknowns) with symbolic transformation algorithms was developed together
     with Hilding Elmqvist and Sven Erik Mattsson from Dynasim AB, Lund, Sweden.
     The MultiBody library is heavily relying on this feature which is a
     prerequiste for a truely \"object-oriented\" multi-body systems library,
     where components can be connected together in any meaningful way.<li>
<li> The Examples.Loops.EngineV6 demo of a six cylinder V6 engine with
     6 planar loops and 1 degree of freedom is from Hilding Elmqvist and
     Sven Erik Mattsson.</li>
<li> MultiBody.Forces.LineForceWithMass is based on model
     \"RelativeDistance\" from the Modelica VehicleDynamics library of
     Johan Andreasson from Royal Institute of Technology, Stockholm, Sweden.</li>
<li> The 1D components (Parts.Rotor1D, Parts.BevelGear1D, Mounting1D) and
     Joints.GearConstraints are from Christian Schweiger.</li>
<li> The design of this library is based on work carried out
     in the EU RealSim project (Real-time Simulation for Design of
     Multi-physics Systems) funded by the European Commission within
     the Information Societies Technology (IST) programme under
     contract number IST 1999-11979.
     </li>
</ul>

</html>
"));
  end Contact;

end UsersGuide;


model World
  "World coordinate system + gravity field + default animation definition"

  import SI = Modelica.SIunits;

  annotation (
    preferedView="info",
    defaultComponentName="world",
    defaultComponentPrefixes="inner",
    missingInnerMessage="No \"world\" component is defined. A default world
component with the default gravity field will be used
(g=9.81 in negative y-axis). If this is not desired,
drag MultiBody.World into the top level of your model.",
    Coordsys(
      extent=[-100, -100; 100, 100],
      grid=[2, 2],
      component=[20, 20]),
    Window(
      x=0.13,
      y=0.1,
      width=0.81,
      height=0.83),
    Icon(
      Rectangle(extent=[-100, 100; 100, -100], style(color=0, fillColor=7)),
      Line(points=[-100, -118; -100, 61], style(color=0, thickness=2)),
      Polygon(points=[-100, 100; -120, 60; -80, 60; -100, 100; -100, 100],
          style(
          color=0,
          fillColor=0,
          fillPattern=1)),
      Line(points=[-119, -100; 59, -100], style(color=0, thickness=2)),
      Polygon(points=[99, -100; 59, -80; 59, -120; 99, -100], style(
          color=0,
          fillColor=0,
          fillPattern=1)),
      Text(extent=[-140, 165; 140, 103], string="%name"),
      Text(
        extent=[95, -113; 144, -162],
        string="%label1",
        style(color=0)),
      Text(
        extent=[-170, 127; -119, 77],
        string="%label2",
        style(color=0)),
      Line(points=[-56, 78; -56, -26]),
      Polygon(points=[-68, -26; -56, -66; -44, -26; -68, -26], style(fillColor=
              3)),
      Line(points=[2, 78; 2, -26]),
      Polygon(points=[-10, -26; 2, -66; 14, -26; -10, -26], style(fillColor=3)),
      Line(points=[66, 80; 66, -26]),
      Polygon(points=[54, -26; 66, -66; 78, -26; 54, -26], style(fillColor=3))),
    Diagram,
    Documentation(info="<HTML>
<p>
Model <b>World</b> represents a global coordinate system fixed in
ground. This model serves several purposes:
<ul>
<li> It is used as <b>inertial system</b> in which
     the equations of all elements of the MultiBody library
     are defined.</li>
<li> It is the world frame of an <b>animation window</b> in which
     all elements of the MultiBody library are visualized.</li>
<li> It is used to define the <b>gravity field</b> in which a
     multi-body model is present. Default is a uniform gravity
     field where the gravity acceleration vector g is the
     same at every position. Additionally, a point gravity field
     can be selected.</li>
<li> It is used to define <b>default settings</b> of animation properties
     (e.g. the diameter of a sphere representing by default
     the center of mass of a body, or the diameters of the cylinders
     representing a revolute joint).</li>
<li> It is used to define a <b>visual representation</b> of the
     world model (= 3 coordinate axes with labels) and of the defined
     gravity field.<br>
    <IMG SRC=\"../Images/world.png\" ALT=\"MultiBodys.World\">
</li>
</ul>
<p>
Since the gravity field function is required from all bodies with mass
and the default settings of animation properties are required
from nearly every component, exactly one instance of model World needs
to be present in every model on the top level. The basic declaration
needs to be:
</p>
<pre>
    <b>inner</b> MultiBody.World world
</pre>
<p>
Note, it must be an <b>inner</b> declaration with instance name <b>world</b>
in order that this world object can be accessed from all objects in the
model. When dragging the \"World\" object from the package browser into
the diagram layer, this declaration is automatically generated
(this is defined via annotations in model World).
</p>
<p>
All vectors and tensors of a mechanical system are resolved in a
frame that is local to the corresponding component. Usually,
if all relative joint coordinates vanish, the local frames
of all components are parallel to each other, as well as to the
world frame (this holds as long as a Parts.FixedRotation,
component is <b>not</b> used). In this \"reference configuration\"
it is therefore
alternatively possible to resolve all vectors in the world
frame, since all frames are parallel to each other.
This is often very convenient. In order to give some visual
support in such a situation, in the icon of a World instance
two axes of the world frame are shown and the labels
of these axes can be set via parameters.
</p>
</HTML>
"));

  parameter Boolean enableAnimation=true
    "= true, if animation of all components is enabled";
  parameter Boolean animateWorld=true
    "= true, if world coordinate system shall be visualized";
  parameter Boolean animateGravity=true
    "= true, if gravity field shall be visualized (acceleration vector or field center)";
  parameter MultiBody.Types.AxisLabel label1="x"
    "Label of horizontal axis in icon";
  parameter MultiBody.Types.AxisLabel label2="y"
    "Label of vertical axis in icon";
  parameter MultiBody.Types.GravityTypes.Temp gravityType=MultiBody.Types.
      GravityTypes.UniformGravity "Type of gravity field"
    annotation (Evaluate=true);
  parameter SI.Acceleration g=9.81
    "|gravityType = UniformGravity| Constant gravity acceleration";
  parameter MultiBody.Types.Axis n={0,-1,0}
    "|gravityType = UniformGravity| Direction of gravity resolved in world frame (gravity = g*n/length(n))"
    annotation (Evaluate=true);
  parameter Real mue(
    unit="m3/s2",
    min=0) = 3.986e14
    "|gravityType = PointGravity| Gravity field constant (default = field constant of earth)";

  parameter SI.Distance axisLength=nominalLength/2
    "|Animation|if animateWorld = true| Length of world axes arrows";
  parameter SI.Distance axisDiameter=axisLength/defaultFrameDiameterFraction
    "|Animation|if animateWorld = true| Diameter of world axes arrows";
  parameter Boolean axisShowLabels=true
    "|Animation|if animateWorld = true| = true, if labels shall be shown";
  parameter MultiBody.Types.Color axisColor_x=MultiBody.Types.Defaults.
      FrameColor "|Animation|if animateWorld = true| Color of x-arrow";
  parameter MultiBody.Types.Color axisColor_y=axisColor_x
    "|Animation|if animateWorld = true| Color of y-arrow";
  parameter MultiBody.Types.Color axisColor_z=axisColor_x
    "|Animation|if animateWorld = true| Color of z-arrow";

  parameter SI.Position gravityArrowTail[3]={0,0,0}
    "|Animation|if animateGravity = true and gravityType = UniformGravity| Position vector from origin of world frame to arrow tail, resolved in world frame";
  parameter SI.Length gravityArrowLength=axisLength/2
    "|Animation|if animateGravity = true and gravityType = UniformGravity| Length of gravity arrow";
  parameter SI.Diameter gravityArrowDiameter=gravityArrowLength/
      defaultWidthFraction
    "|Animation|if animateGravity = true and gravityType = UniformGravity| Diameter of gravity arrow";
  parameter MultiBody.Types.Color gravityArrowColor={0,230,0}
    "|Animation|if animateGravity = true and gravityType = UniformGravity| Color of gravity arrow";
  parameter SI.Diameter gravitySphereDiameter=12742000
    "|Animation|if animateGravity = true and gravityType = PointGravity| Diameter of sphere representing gravity center (default = mean diameter of earth)";
  parameter MultiBody.Types.Color gravitySphereColor={0,230,0}
    "|Animation|if animateGravity = true and gravityType = PointGravity| Color of gravity sphere";

  parameter SI.Length nominalLength=1
    "|Defaults|| \"Nominal\" length of multi-body system";
  parameter SI.Length defaultAxisLength=nominalLength/5
    "|Defaults|| Default for length of a frame axis (but not world frame)";
  parameter SI.Length defaultJointLength=nominalLength/10
    "|Defaults|| Default for the fixed length of a shape representing a joint";
  parameter SI.Length defaultJointWidth=nominalLength/20
    "|Defaults|| Default for the fixed width of a shape representing a joint";
  parameter SI.Length defaultForceLength=nominalLength/10
    "|Defaults|| Default for the fixed length of a shape representing a force (e.g. damper)";
  parameter SI.Length defaultForceWidth=nominalLength/20
    "|Defaults|| Default for the fixed width of a shape represening a force (e.g. spring, bushing)";
  parameter SI.Length defaultBodyDiameter=nominalLength/9
    "|Defaults|| Default for diameter of sphere representing the center of mass of a body";
  parameter Real defaultWidthFraction=20
    "|Defaults|| Default for shape width as a fraction of shape length (e.g., for Parts.FixedTranslation)";
  parameter SI.Length defaultArrowDiameter=nominalLength/40
    "|Defaults|| Default for arrow diameter (e.g., of forces, torques, sensors)";
  parameter Real defaultFrameDiameterFraction=40
    "|Defaults|| Default for arrow diameter of a coordinate system as a fraction of axis length";

  MultiBody.Interfaces.Frame_b frame_b annotation (extent=[100, -15; 120, 15]);

  /* The World object can only use the MultiBody.Visualizers.Advanced.Shape model, but no
     other models in package MultiBody.Visualizers, since the other models access
     data of the "outer MultiBody.World world" object, i.e., there are
     mutually dependent classes. For this reason, the higher level visualization
     objects cannot be used.
  */
protected
  parameter Integer ndim=if enableAnimation and animateWorld then 1 else 0;
  parameter Integer ndim2=if enableAnimation and animateWorld and
      axisShowLabels then 1 else 0;

  // Parameters to define axes
  parameter SI.Length headLength=min(axisLength, axisDiameter*Types.Defaults.
      FrameHeadLengthFraction);
  parameter SI.Length headWidth=axisDiameter*Types.Defaults.
      FrameHeadWidthFraction;
  parameter SI.Length lineLength=max(0, axisLength - headLength);
  parameter SI.Length lineWidth=axisDiameter;

  // Parameters to define axes labels
  parameter SI.Length scaledLabel=Types.Defaults.FrameLabelHeightFraction*
      axisDiameter;
  parameter SI.Length labelStart=1.05*axisLength;

  // x-axis
  MultiBody.Visualizers.Advanced.Shape x_arrowLine[ndim](
    each shapeType="cylinder",
    each length=lineLength,
    each width=lineWidth,
    each height=lineWidth,
    each lengthDirection={1,0,0},
    each widthDirection={0,1,0},
    each color=axisColor_x,
    each specularCoefficient=0);
  MultiBody.Visualizers.Advanced.Shape x_arrowHead[ndim](
    each shapeType="cone",
    each length=headLength,
    each width=headWidth,
    each height=headWidth,
    each lengthDirection={1,0,0},
    each widthDirection={0,1,0},
    each color=axisColor_x,
    each r={lineLength,0,0},
    each specularCoefficient=0);
  MultiBody.Visualizers.Internal.Lines x_label[ndim2](
    each lines=scaledLabel*{[0, 0; 1, 1],[0, 1; 1, 0]},
    each diameter=axisDiameter,
    each color=axisColor_x,
    each r_lines={labelStart,0,0},
    each n_x={1,0,0},
    each n_y={0,1,0},
    each specularCoefficient=0);

  // y-axis
  MultiBody.Visualizers.Advanced.Shape y_arrowLine[ndim](
    each shapeType="cylinder",
    each length=lineLength,
    each width=lineWidth,
    each height=lineWidth,
    each lengthDirection={0,1,0},
    each widthDirection={1,0,0},
    each color=axisColor_y,
    each specularCoefficient=0);
  MultiBody.Visualizers.Advanced.Shape y_arrowHead[ndim](
    each shapeType="cone",
    each length=headLength,
    each width=headWidth,
    each height=headWidth,
    each lengthDirection={0,1,0},
    each widthDirection={1,0,0},
    each color=axisColor_y,
    each r={0,lineLength,0},
    each specularCoefficient=0);
  MultiBody.Visualizers.Internal.Lines y_label[ndim2](
    each lines=scaledLabel*{[0, 0; 1, 1.5],[0, 1.5; 0.5, 0.75]},
    each diameter=axisDiameter,
    each color=axisColor_y,
    each r_lines={0,labelStart,0},
    each n_x={0,1,0},
    each n_y={-1,0,0},
    each specularCoefficient=0);

  // z-axis
  MultiBody.Visualizers.Advanced.Shape z_arrowLine[ndim](
    each shapeType="cylinder",
    each length=lineLength,
    each width=lineWidth,
    each height=lineWidth,
    each lengthDirection={0,0,1},
    each widthDirection={0,1,0},
    each color=axisColor_z,
    each specularCoefficient=0);
  MultiBody.Visualizers.Advanced.Shape z_arrowHead[ndim](
    each shapeType="cone",
    each length=headLength,
    each width=headWidth,
    each height=headWidth,
    each lengthDirection={0,0,1},
    each widthDirection={0,1,0},
    each color=axisColor_z,
    each r={0,0,lineLength},
    each specularCoefficient=0);
  MultiBody.Visualizers.Internal.Lines z_label[ndim2](
    each lines=scaledLabel*{[0, 0; 1, 0],[0, 1; 1, 1],[0, 1; 1, 0]},
    each diameter=axisDiameter,
    each color=axisColor_z,
    each r_lines={0,0,labelStart},
    each n_x={0,0,1},
    each n_y={0,1,0},
    each specularCoefficient=0);

  // Uniform gravity visualization
  parameter Integer ndim_uniformGravity=if enableAnimation and animateGravity
       and gravityType == 1 then 1 else 0;
  parameter SI.Length gravityHeadLength=min(gravityArrowLength,
      gravityArrowDiameter*Types.Defaults.ArrowHeadLengthFraction);
  parameter SI.Length gravityHeadWidth=gravityArrowDiameter*Types.Defaults.
      ArrowHeadWidthFraction;
  parameter SI.Length gravityLineLength=max(0, gravityArrowLength -
      gravityHeadLength);
  MultiBody.Visualizers.Advanced.Shape gravityArrowLine[ndim_uniformGravity](
    each shapeType="cylinder",
    each length=gravityLineLength,
    each width=gravityArrowDiameter,
    each height=gravityArrowDiameter,
    each lengthDirection=n,
    each widthDirection={0,1,0},
    each color=gravityArrowColor,
    each r_shape=gravityArrowTail,
    each specularCoefficient=0);
  MultiBody.Visualizers.Advanced.Shape gravityArrowHead[ndim_uniformGravity](
    each shapeType="cone",
    each length=gravityHeadLength,
    each width=gravityHeadWidth,
    each height=gravityHeadWidth,
    each lengthDirection=n,
    each widthDirection={0,1,0},
    each color=gravityArrowColor,
    each r_shape=gravityArrowTail + Frames.normalize(n)*gravityLineLength,
    each specularCoefficient=0);

  // Point gravity visualization
  parameter Integer ndim_pointGravity=if enableAnimation and animateGravity
       and gravityType == 2 then 1 else 0;
  MultiBody.Visualizers.Advanced.Shape gravitySphere[ndim_pointGravity](
    each shapeType="sphere",
    each r_shape={-gravitySphereDiameter/2,0,0},
    each lengthDirection={1,0,0},
    each length=gravitySphereDiameter,
    each width=gravitySphereDiameter,
    each height=gravitySphereDiameter,
    each color=gravitySphereColor,
    each specularCoefficient=0);

  function gravityAcceleration = gravityAccelerationTypes (
      gravityType=gravityType,
      g=g*MultiBody.Frames.normalize(n),
      mue=mue);

protected
  function gravityAccelerationTypes
    "Gravity field acceleration depending on field type and position"

    extends Modelica.Icons.Function;
    input SI.Position r[3]
      "Position vector from world frame to actual point, resolved in world frame";
    input Integer gravityType "Type of gravity field";
    input SI.Acceleration g[3]
      "Constant gravity acceleration, resolved in world frame, if gravityType=1";
    input Real mue(unit="m3/s2")
      "Field constant of point gravity field, if gravityType=2";
    output SI.Acceleration gravity[3]
      "Gravity acceleration at point r, resolved in world frame";
  algorithm
    gravity := if gravityType == 1 then g else if gravityType == 2 then -(mue/(
      r*r))*(r/Frames.length(r)) else zeros(3);
  end gravityAccelerationTypes;
equation

  defineRoot(frame_b.R);

  assert(Frames.length(n) > 1.e-10,
    "Parameter n of World object is wrong (lenght(n) > 0 required)");
  frame_b.r_0 = zeros(3);
  frame_b.R = Frames.nullRotation();
end World;
end MultiBody;
