encapsulated model Fourbar2
  "One kinematic loop with four bars (with UniversalSpherical joint; 1 non-linear equation)"


  import Modelica;
  import MultiBody;
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Example;

  output SI.Angle j1_phi "angle of revolute joint j1";
  output SI.Position j2_s "distance of prismatic joint j2";
  output SI.AngularVelocity j1_w "axis speed of revolute joint j1";
  output SI.Velocity j2_v "axis velocity of prismatic joint j2";
  annotation(
    experiment(StopTime=5),
    Documentation(info="<html>
<p>
This is a second version of the \"four-bar\" mechanism, see figure:
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Examples/Loops/Fourbar2.png\" ALT=\"model Examples.Loops.Fourbar2\">
</p>
<p>
In this case
the three revolute joints on the left top-side and the two revolute
joints on the right top side have been replaced by the joint <b>UniversalSpherical</b>
that is a rod connecting a spherical and a universal joint. This joint is defined
by <b>1 constraint</b> stating that the distance between the two spherical joints is
constant. Using this joint in a kinematic loop reduces the sizes of
non-linear algebraic equations. For this loop, only one non-linear
algebraic system of equations of order 1 remains.
</p>
<p>
At the UniversalSpherical joint an additional frame_ia fixed to the rod
is present where components can be attached to the connecting rod. In this
example just a coordinate system is attached to visualize frame_ia (coordinate
system on the right in blue color).
</p>
<p>
Another feature is that the length of the connecting rod can be
automatically calculated during <b>initialization</b>. In order to do this,
another initialization condition has to be given. In this example, the
initial value of the distance of the prismatic joint j2 has been fixed
(via the \"Initialization\" menu) and the rod length of joint
\"UniversalSpherical\" is computed during initialization since parameter
<b>computeLength</b> = <b>true</b> is set in the joint parameter
menu. The main advantage is that during initialization no non-linear
system of equation is solved and therefore initialization always works.
To be precise, the following trivial non-linear equation is actually solved
for rodLength:
</p>
<pre>
   rodLength*rodLength = f(angle of revolute joint, distance of prismatic joint)
</pre>
</html>"),
    Diagram);

  inner MultiBody.World world annotation( extent=[-80, -80; -60, -60]);
  MultiBody.Joints.ActuatedRevolute j1(
    n={1,0,0},
    initType=MultiBody.Types.Init.PositionVelocity,
    enforceStates=true,
    w_start=300) annotation( extent=[-54, -40; -34, -20]);
  MultiBody.Joints.Prismatic j2(
    n={1,0,0},
    s_offset=-0.2,
    boxWidth=0.05,
    initType=MultiBody.Types.Init.Position)
    annotation( extent=[12, -80; 32, -60]);
  MultiBody.Parts.BodyCylinder b1(r={0,0.5,0.1}, diameter=0.05)
    annotation( extent=[-40, -10; -20, 10], rotation=90);
  MultiBody.Parts.BodyCylinder b2(r={0,0.2,0}, diameter=0.05)
    annotation( extent=[40, -60; 60, -40], rotation=90);
  MultiBody.Joints.UniversalSpherical universalSpherical(
    n1_a={0,1,0},
    computeRodLength=true,
    rRod_ia={-1,0.3,0.1}) annotation( extent=[0, 18; -20, 38]);
  MultiBody.Parts.FixedTranslation b3(r={1.2,0,0}, animation=false)
    annotation( extent=[-32, -80; -12, -60]);
  MultiBody.Visualizers.FixedFrame fixedFrame(color_x={0,0,255})
    annotation( extent=[-20, 60; 0, 80], rotation=90);
equation
  j1_phi = j1.phi;
  j2_s = j2.s;
  j1_w = j1.w;
  j2_v = j2.v;
  connect(j2.frame_b, b2.frame_a) annotation( points=[33, -70; 50, -70; 50, -61],
       style(color=0, thickness=2));
  connect(j1.frame_b, b1.frame_a) annotation( points=[-33, -30; -30, -30; -30,
        -11], style(color=0, thickness=2));
  connect(j1.frame_a, world.frame_b) annotation( points=[-55, -30; -59, -30; -59,
         -70], style(color=0, thickness=2));
  connect(b1.frame_b, universalSpherical.frame_b) annotation( points=[-30, 11;
        -30, 28; -21, 28], style(color=0, thickness=2));
  connect(universalSpherical.frame_a, b2.frame_b)
    annotation( points=[1, 28; 50, 28; 50, -39], style(color=0, thickness=2));
  connect(b3.frame_a, world.frame_b)
    annotation( points=[-33, -70; -59, -70], style(color=0, thickness=2));
  connect(b3.frame_b, j2.frame_a)
    annotation( points=[-11, -70; 11, -70], style(color=0, thickness=2));
  connect(fixedFrame.frame_a, universalSpherical.frame_ia) annotation( points=[
        -10, 59; -10, 50; -6, 50; -6, 39.05], style(color=0, thickness=2));
end Fourbar2;
