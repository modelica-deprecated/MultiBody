encapsulated model PlanarLoops_analytic
  "Mechanism with three planar kinematic loops and one degree-of-freedom with analytic loop handling (with JointRRR joints)"


  import Modelica;
  import MultiBody;
  import SI = Modelica.SIunits;
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Example;
  parameter SI.Length rh[3]={0.5,0,0};
  parameter SI.Length rv[3]={0,0.5,0};

  parameter SI.Length r1b[3]={0.1,0.5,0};
  parameter SI.Length r1a[3]=r1b + rh - rv;

  parameter SI.Length r2b[3]={0.1,0.6,0};
  parameter SI.Length r2a[3]=r2b + rh - r1b;

  parameter SI.Length r3b[3]={0,0.55,0};
  parameter SI.Length r3a[3]=r3b + rh - r2b;

  annotation(
    experiment(StopTime=5),
    Documentation(info="<html>
<p>
It is demonstrated how the MultiBody.Joints.Assemblies.JointRRR joint can be
used to solve the non-linear equations of coupled planar loops analytically.
In the mechanism below no non-linear equation occurs any more from the tool
view, since these equations are solved analytically in the JointRRR joints.
For more details, see
<a href=\"Modelica://MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling\">
MultiBody.UsersGuide.Tutorial.LoopStructures.AnalyticLoopHandling</a>.
</p>
<p align=\"center\">
<IMG SRC=\"../Images/Examples/Loops/PlanarLoops.png\" ALT=\"model Examples.Loops.PlanarLoops\">
</p>
</html>"),
    Diagram,
    Coordsys(grid=[1, 1], component=[20, 20]));

  inner MultiBody.World world annotation( extent=[-80, -60; -60, -40]);
  MultiBody.Joints.Assemblies.JointRRR jointRRR1(
    rRod1_ia=r1a,
    rRod2_ib=r1b,
    checkTotalPower=true) annotation( extent=[-20, 0; 0, 20], rotation=-90);
  MultiBody.Joints.ActuatedRevolute rev(initType=MultiBody.Types.Init.Velocity)
    annotation( extent=[-60, -20; -40, 0], rotation=90);
  MultiBody.Parts.FixedTranslation rod1(r=rv)
    annotation( extent=[-60, 20; -40, 40], rotation=90);
  MultiBody.Parts.FixedTranslation rod2(r=rh)
    annotation( extent=[-40, -60; -20, -40], rotation=0);
  MultiBody.Parts.Body body1(
    m=1,
    cylinderColor={155,155,155},
    r_CM=jointRRR1.rRod1_ia/2)
    annotation( extent=[-10, 60; 10, 80], rotation=90);
  Modelica.Mechanics.Rotational.Position position
    annotation( extent=[-84, -20; -64, 0]);
  Modelica.Blocks.Sources.Sine sine(amplitude={0.7})
    annotation( extent=[-100, 20; -80, 40], rotation=-90);
  MultiBody.Joints.Assemblies.JointRRR jointRRR2(
    rRod1_ia=r2a,
    rRod2_ib=r2b,
    checkTotalPower=true) annotation( extent=[20, 0; 40, 20], rotation=-90);
  MultiBody.Parts.FixedTranslation rod3(r=rh)
    annotation( extent=[0, -60; 20, -40], rotation=0);
  MultiBody.Parts.Body body2(
    m=1,
    cylinderColor={155,155,155},
    r_CM=jointRRR2.rRod1_ia/2) annotation( extent=[30, 60; 50, 80], rotation=90);
  MultiBody.Joints.Assemblies.JointRRR jointRRR3(
    rRod1_ia=r3a,
    rRod2_ib=r3b,
    checkTotalPower=true) annotation( extent=[60, 0; 80, 20], rotation=-90);
  MultiBody.Parts.FixedTranslation rod4(r=rh)
    annotation( extent=[40, -60; 60, -40], rotation=0);
  MultiBody.Parts.Body body3(
    m=1,
    cylinderColor={155,155,155},
    r_CM=jointRRR3.rRod1_ia/2) annotation( extent=[70, 60; 90, 80], rotation=90);
equation
  connect(world.frame_b, rev.frame_a) annotation( points=[-59, -50; -50, -50; -50,
         -21], style(color=0, thickness=2));
  connect(rod1.frame_a, rev.frame_b)
    annotation( points=[-50, 19; -50, 1], style(color=0, thickness=2));
  connect(rod1.frame_b, jointRRR1.frame_a) annotation( points=[-50, 41; -50, 50;
         -10, 50; -10, 21], style(color=0, thickness=2));
  connect(rod2.frame_a, world.frame_b)
    annotation( points=[-41, -50; -59, -50], style(color=0, thickness=2));
  connect(rod2.frame_b, jointRRR1.frame_b) annotation( points=[-19, -50; -10, -50;
         -10, -1], style(color=0, thickness=2));
  connect(jointRRR1.frame_ia, body1.frame_a) annotation( points=[1, 18; 6, 18;
        6, 30; -6.73533e-016, 30; -6.73533e-016, 59], style(color=0, thickness=
          2));
  connect(position.flange_b, rev.axis)
    annotation( points=[-64, -10; -60, -10], style(color=0));
  connect(sine.outPort, position.inPort)
    annotation( points=[-90, 19; -90, -10; -86, -10], style(color=3));
  connect(rod3.frame_a, rod2.frame_b)
    annotation( points=[-1, -50; -19, -50], style(color=0, thickness=2));
  connect(rod3.frame_b, jointRRR2.frame_b) annotation( points=[21, -50; 30, -50;
         30, -1], style(color=0, thickness=2));
  connect(jointRRR2.frame_ia, body2.frame_a) annotation( points=[41, 18; 46, 18;
         46, 32; 40, 32; 40, 59], style(color=0, thickness=2));
  connect(jointRRR1.frame_im, jointRRR2.frame_a) annotation( points=[1, 10.1;
        12, 10.1; 12, 30; 30, 30; 30, 21], style(color=0, thickness=2));
  connect(rod3.frame_b, rod4.frame_a)
    annotation( points=[21, -50; 39, -50], style(color=0, thickness=2));
  connect(rod4.frame_b, jointRRR3.frame_b) annotation( points=[61, -50; 70, -50;
         70, -1], style(color=0, thickness=2));
  connect(jointRRR2.frame_im, jointRRR3.frame_a) annotation( points=[41, 10.1;
        52, 10.1; 52, 30; 70, 30; 70, 21], style(color=0, thickness=2));
  connect(jointRRR3.frame_ia, body3.frame_a) annotation( points=[81, 18; 88, 18;
         88, 30; 80, 30; 80, 59], style(color=0, thickness=2));
end PlanarLoops_analytic;
