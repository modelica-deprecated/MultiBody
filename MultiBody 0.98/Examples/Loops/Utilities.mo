package Utilities "Utility models for Examples.Loops"
  extends Modelica.Icons.Library;

  model Cylinder
    import SI = Modelica.SIunits;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.Length cylinderTopPosition=0.42
      "Length from crank shaft to end of cylinder.";
    parameter SI.Length pistonLength=0.1 "Length of cylinder";
    parameter SI.Length rodLength=0.2 "Length of rod";
    parameter SI.Length crankLength=0.2 "Length of crank shaft in x direction";
    parameter SI.Length crankPinOffset=0.1
      "Offset of crank pin from center axis";
    parameter SI.Length crankPinLength=0.1
      "Offset of crank pin from center axis";
    parameter SI.Angle cylinderInclination=0 "Inclination of cylinder";
    parameter SI.Angle crankAngleOffset=0 "Offset for crank angle";
    parameter SI.Length cylinderLength=cylinderTopPosition - (pistonLength +
        rodLength - crankPinOffset) "Maximum length of cylinder volume";

    MultiBody.Parts.BodyCylinder Piston(
      diameter=0.1,
      r={0,pistonLength,0},
      color={180,180,180},
      animation=animation) annotation (extent=[45, 80; -16, 59], rotation=270);
    MultiBody.Parts.BodyBox Rod(
      widthDirection={1,0,0},
      height=0.06,
      color={0,0,200},
      width=0.02,
      r_shape={0,-0.02,0},
      r={0,rodLength,0},
      animation=animation) annotation (extent=[4, -2; 24, 18], rotation=90);
    MultiBody.Joints.Revolute B2(
      n={1,0,0},
      phi_start=0,
      cylinderLength=0.02,
      animation=animation,
      cylinderDiameter=0.055) annotation (extent=[4, 25; 24, 45], rotation=0);
    MultiBody.Parts.BodyBox Crank4(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,-crankPinOffset,0},
      animation=animation)
      annotation (extent=[30.5, -64; 50.5, -84], rotation=90);
    MultiBody.Parts.BodyCylinder Crank3(
      r_shape={-0.01,0,0},
      length=0.12,
      diameter=0.03,
      r={crankPinLength,0,0},
      color={180,180,180},
      animation=animation) annotation (extent=[4.5, -60; 24.5, -40], rotation=0);
    MultiBody.Parts.BodyCylinder Crank1(
      diameter=0.05,
      r_shape={-0.01,0,0},
      length=0.12,
      r={crankLength - crankPinLength,0,0},
      color={180,180,180},
      animation=animation) annotation (extent=[-50, -100; -30, -80], rotation=0);
    MultiBody.Parts.BodyBox Crank2(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,crankPinOffset,0},
      animation=animation) annotation (extent=[-20, -86; 0, -66], rotation=90);
    MultiBody.Joints.Revolute B1(
      n={1,0,0},
      planarCutJoint=true,
      cylinderLength=0.02,
      animation=animation,
      cylinderDiameter=0.055) annotation (extent=[4, -27; 24, -7], rotation=0);
    MultiBody.Parts.FixedTranslation Mid(r={crankPinLength/2,0,0}, animation=
          false) annotation (extent=[-6, -46; 14, -26]);
    MultiBody.Joints.ActuatedPrismatic Cylinder(
      s_start=-0.3,
      n={0,-1,0},
      boxWidth=0.02) annotation (extent=[4, 89; 24, 109], rotation=-90);
    MultiBody.Interfaces.Frame_a crank_a
      annotation (extent=[-120, -105; -100, -75]);
    MultiBody.Interfaces.Frame_b crank_b
      annotation (extent=[100, -105; 120, -75]);
    MultiBody.Interfaces.Frame_a cylinder_a
      annotation (extent=[-120, 115; -100, 145]);
    MultiBody.Interfaces.Frame_b cylinder_b
      annotation (extent=[100, 115; 120, 145]);
    MultiBody.Parts.FixedTranslation Mounting(r={crankLength,0,0}, animation=
          false) annotation (extent=[0, 120; 20, 140]);
    MultiBody.Parts.FixedRotation CylinderInclination(
      r={crankLength - crankPinLength/2,0,0},
      n_y={0,cos(cylinderInclination),sin(cylinderInclination)},
      animation=false,
      rotationType=MultiBody.Types.RotationTypes.TwoAxesVectors)
      annotation (extent=[-60, 30; -40, 50]);
    MultiBody.Parts.FixedRotation CrankAngle1(
      n_y={0,cos(crankAngleOffset),sin(crankAngleOffset)},
      animation=false,
      rotationType=MultiBody.Types.RotationTypes.TwoAxesVectors)
      annotation (extent=[-90, -100; -70, -80]);
    MultiBody.Parts.FixedRotation CrankAngle2(
      n_y={0,cos(-crankAngleOffset),sin(-crankAngleOffset)},
      animation=false,
      rotationType=MultiBody.Types.RotationTypes.TwoAxesVectors)
      annotation (extent=[60, -100; 80, -80]);
    MultiBody.Parts.FixedTranslation CylinderTop(r={0,cylinderTopPosition,0},
        animation=false) annotation (extent=[-40, 61; -20, 81], rotation=90);
    GasForce gasForce(L=cylinderLength, d=0.1)
      annotation (extent=[40, 97; 60, 117], rotation=90);
  equation
    connect(B1.frame_a, Mid.frame_b) annotation (points=[3, -17; -6, -17; -6, -29;
           22, -29; 22, -36; 15, -36], style(color=0, thickness=2));
    annotation (
      Coordsys(
        extent=[-100, -150; 100, 150],
        grid=[1, 1],
        component=[20, 20]),
      Diagram,
      Icon(
        Polygon(points=[-60, -50; -60, 100; 60, 100; 60, -52; 100, -52; 100,
              150; -100, 150; -100, -50; -60, -50], style(color=0, fillColor=8)),

        Rectangle(extent=[-58, 89; 58, 13], style(gradient=1, fillColor=8)),
        Rectangle(extent=[-60, 81; 60, 75], style(color=0, fillColor=0)),
        Rectangle(extent=[-60, 67; 60, 61], style(color=0, fillColor=0)),
        Rectangle(extent=[-60, 55; 60, 49], style(color=0, fillColor=0)),
        Polygon(points=[-60, 11; -42, 23; 38, 23; 56, 11; -60, 11], style(
              pattern=0, fillColor=7)),
        Ellipse(extent=[-6, 41; 2, 33], style(color=0, fillColor=0)),
        Ellipse(extent=[-40, -129; 40, -49], style(color=8)),
        Line(points=[0, -90; 26, -58; -2, 37], style(color=0, thickness=4)),
        Text(extent=[-150, -124; 164, -186], string="%name"),
        Line(points=[-100, -90; 100, -91], style(color=0, thickness=2))));

    connect(Mounting.frame_a, cylinder_a)
      annotation (points=[-1, 130; -110, 130], style(color=0, thickness=2));
    connect(Mounting.frame_b, cylinder_b)
      annotation (points=[21, 130; 110, 130], style(color=0, thickness=2));
    connect(Rod.frame_a, B1.frame_b) annotation (points=[14, -3; 14, -9; 30, -9;
           30, -17; 25, -17], style(color=0, thickness=2));
    connect(Cylinder.frame_b, Piston.frame_b) annotation (points=[14, 88; 14,
          81.05; 14.5, 81.05], style(color=0, thickness=2));
    connect(Crank1.frame_a, CrankAngle1.frame_b)
      annotation (points=[-51, -90; -69, -90], style(color=0, thickness=2));
    connect(B2.frame_a, Piston.frame_a) annotation (points=[3, 35; -6, 35; -6,
          49; 14.5, 49; 14.5, 57.95], style(color=0, thickness=2));
    connect(Rod.frame_b, B2.frame_b) annotation (points=[14, 19; 14, 23; 32, 23;
           32, 35; 25, 35], style(color=0, thickness=2));
    connect(CrankAngle1.frame_a, crank_a)
      annotation (points=[-91, -90; -110, -90], style(color=0, thickness=2));
    connect(Crank4.frame_b, CrankAngle2.frame_a) annotation (points=[40.5, -85;
           40.5, -90; 59, -90], style(color=0, thickness=2));
    connect(CrankAngle2.frame_b, crank_b)
      annotation (points=[81, -90; 110, -90], style(color=0, thickness=2));
    connect(Cylinder.bearing, gasForce.flange_b) annotation (points=[20, 103;
          34, 103; 34, 117; 50, 117], style(color=58));
    connect(Cylinder.axis, gasForce.flange_a)
      annotation (points=[20, 91; 50, 91; 50, 97], style(color=58));
    connect(CylinderInclination.frame_b, CylinderTop.frame_a)
      annotation (points=[-39, 40; -30, 40; -30, 60]);
    connect(CylinderInclination.frame_a, cylinder_a) annotation (points=[-61,
          40; -70, 40; -70, 130; -110, 130], style(color=0, thickness=2));
    connect(Crank1.frame_b, Crank2.frame_a) annotation (points=[-29, -90; -10,
          -90; -10, -87], style(color=0, thickness=2));
    connect(Crank3.frame_b, Crank4.frame_a) annotation (points=[25.5, -50; 40.5,
           -50; 40.5, -63], style(color=0, thickness=2));
    connect(Crank3.frame_a, Crank2.frame_b) annotation (points=[3.5, -50; -10,
          -50; -10, -65], style(color=0, thickness=2));
    connect(Crank2.frame_b, Mid.frame_a) annotation (points=[-10, -65; -10, -36;
           -7, -36], style(color=0, thickness=2));
    connect(CylinderTop.frame_b, Cylinder.frame_a) annotation (points=[-30, 82;
           -30, 120; 14, 120; 14, 110], style(color=0, thickness=2));
  end Cylinder;

  model GasForce
    import SI = Modelica.SIunits;

    extends Modelica.Mechanics.Translational.Interfaces.Compliant;
    parameter SI.Length L "Length of cylinder";
    parameter SI.Length d "diameter of cylinder";
    parameter Real k0=0.01;
    parameter Real k1=1;
    parameter Real k=1;
    constant Real pi=Modelica.Constants.pi;
    constant Real PI=Modelica.Constants.pi;
    // Only for compatibility reasons
    SI.Position x;
    SI.Position y;
    SI.Density dens;
    SI.Pressure press "cylinder pressure";
    SI.Volume V;
    SI.Temperature T;
    SI.Velocity v_rel;
    annotation (Icon(
        Rectangle(extent=[-90, 50; 90, -50], style(
            color=0,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 50; -20, -50], style(fillColor=3, fillPattern=1)),

        Rectangle(extent=[-90, 10; -40, -10], style(fillColor=3, fillPattern=1)),

        Polygon(points=[60, 2; 54, 2; 0, 2; 0, 10; -20, 0; 0, -10; 0, -4; 60, -4;
               60, 2], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Text(extent=[-100, 120; 100, 60], string="%name")), Diagram(
        Rectangle(extent=[-90, 50; 90, -50], style(
            color=0,
            gradient=0,
            fillColor=8,
            fillPattern=1)),
        Rectangle(extent=[-40, 50; -20, -50], style(fillColor=3, fillPattern=1)),

        Rectangle(extent=[-90, 10; -40, -10], style(fillColor=3, fillPattern=1)),

        Polygon(points=[60, 2; 54, 2; 0, 2; 0, 10; -20, 0; 0, -10; 0, -4; 60, -4;
               60, 2], style(
            color=1,
            fillColor=1,
            fillPattern=1)),
        Text(extent=[-100, 120; 100, 60], string="%name")));
  equation

    y = -s_rel/L;
    x = 1 + s_rel/L;
    v_rel = der(s_rel);

    press = if v_rel < 0 then (if x < 0.987 then 177.4132*x^4 - 287.2189*x^3 +
      151.8252*x^2 - 24.9973*x + 2.4 else 2836360*x^4 - 10569296*x^3 + 14761814
      *x^2 - 9158505*x + 2129670) else (if x > 0.93 then -3929704*x^4 +
      14748765*x^3 - 20747000*x^2 + 12964477*x - 3036495 else 145.930*x^4 -
      131.707*x^3 + 17.3438*x^2 + 17.9272*x + 2.4);

    f = -1.0E5*press*pi*d^2/4;

    V = k0 + k1*(1 - x);
    dens = 1/V;
    press*V = k*T;
  end GasForce;

  model Cylinder_analytic
    "One cylinder with analytic handling of kinematic loop"
    import SI = Modelica.SIunits;
    parameter Boolean animation=true "= true, if animation shall be enabled";
    parameter SI.Length cylinderTopPosition=0.42
      "Length from crank shaft to end of cylinder.";
    parameter SI.Length pistonLength=0.1 "Length of cylinder";
    parameter SI.Length rodLength=0.2 "Length of rod";
    parameter SI.Length crankLength=0.2 "Length of crank shaft in x direction";
    parameter SI.Length crankPinOffset=0.1
      "Offset of crank pin from center axis";
    parameter SI.Length crankPinLength=0.1
      "Offset of crank pin from center axis";
    parameter SI.Angle cylinderInclination=0 "Inclination of cylinder";
    parameter SI.Angle crankAngleOffset=0 "Offset for crank angle";
    parameter SI.Length cylinderLength=cylinderTopPosition - (pistonLength +
        rodLength - crankPinOffset) "Maximum length of cylinder volume";

    MultiBody.Parts.BodyBox Crank4(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,-crankPinOffset,0},
      animation=animation)
      annotation (extent=[30.5, -64; 50.5, -84], rotation=90);
    MultiBody.Parts.BodyCylinder Crank3(
      r_shape={-0.01,0,0},
      length=0.12,
      diameter=0.03,
      r={crankPinLength,0,0},
      color={180,180,180},
      animation=animation) annotation (extent=[4.5, -60; 24.5, -40], rotation=0);
    MultiBody.Parts.BodyCylinder Crank1(
      diameter=0.05,
      r_shape={-0.01,0,0},
      length=0.12,
      r={crankLength - crankPinLength,0,0},
      color={180,180,180},
      animation=animation) annotation (extent=[-50, -100; -30, -80], rotation=0);
    MultiBody.Parts.BodyBox Crank2(
      height=0.05,
      widthDirection={1,0,0},
      width=0.02,
      r={0,crankPinOffset,0},
      animation=animation) annotation (extent=[-20, -86; 0, -66], rotation=90);
    MultiBody.Parts.FixedTranslation Mid(r={crankPinLength/2,0,0}, animation=
          false) annotation (extent=[-6, -46; 14, -26]);
    MultiBody.Interfaces.Frame_a crank_a
      annotation (extent=[-120, -105; -100, -75]);
    MultiBody.Interfaces.Frame_b crank_b
      annotation (extent=[100, -105; 120, -75]);
    MultiBody.Interfaces.Frame_a cylinder_a
      annotation (extent=[-120, 115; -100, 145]);
    MultiBody.Interfaces.Frame_b cylinder_b
      annotation (extent=[100, 115; 120, 145]);
    MultiBody.Parts.FixedTranslation Mounting(r={crankLength,0,0}, animation=
          false) annotation (extent=[0, 120; 20, 140]);
    MultiBody.Parts.FixedRotation CylinderInclination(
      r={crankLength - crankPinLength/2,0,0},
      n_y={0,cos(cylinderInclination),sin(cylinderInclination)},
      animation=false,
      rotationType=MultiBody.Types.RotationTypes.TwoAxesVectors)
      annotation (extent=[-60, 30; -40, 50]);
    MultiBody.Parts.FixedRotation CrankAngle1(
      n_y={0,cos(crankAngleOffset),sin(crankAngleOffset)},
      animation=false,
      rotationType=MultiBody.Types.RotationTypes.TwoAxesVectors)
      annotation (extent=[-90, -100; -70, -80]);
    MultiBody.Parts.FixedRotation CrankAngle2(
      n_y={0,cos(-crankAngleOffset),sin(-crankAngleOffset)},
      animation=false,
      rotationType=MultiBody.Types.RotationTypes.TwoAxesVectors)
      annotation (extent=[60, -100; 80, -80]);
    MultiBody.Parts.FixedTranslation CylinderTop(r={0,cylinderTopPosition,0},
        animation=false) annotation (extent=[-40, 60; -20, 80], rotation=90);
    Joints.Assemblies.JointRRP jointRRP(
      n_a={1,0,0},
      n_b={0,-1,0},
      rRod1_ia={0,rodLength,0},
      animation=false,
      rRod2_ib=-{0,pistonLength,0})
      annotation (extent=[40, -20; 0, 20], rotation=90);
    MultiBody.Parts.BodyBox Rod(
      widthDirection={1,0,0},
      height=0.06,
      color={0,0,200},
      width=0.02,
      r_shape={0,-0.02,0},
      r={0,rodLength,0},
      animation=animation) annotation (extent=[57, -9; 77, 11], rotation=90);
    MultiBody.Parts.BodyCylinder Piston(
      diameter=0.1,
      r={0,pistonLength,0},
      color={180,180,180},
      animation=animation) annotation (extent=[50, 55; 111, 34], rotation=270);
    GasForce gasForce(L=cylinderLength, d=0.1)
      annotation (extent=[10, 50; 30, 70], rotation=180);
    annotation (
      Coordsys(
        extent=[-100, -150; 100, 150],
        grid=[1, 1],
        component=[20, 20]),
      Diagram,
      Icon(
        Polygon(points=[-60, -50; -60, 100; 60, 100; 60, -52; 100, -52; 100,
              150; -100, 150; -100, -50; -60, -50], style(color=0, fillColor=8)),

        Rectangle(extent=[-58, 89; 58, 13], style(gradient=1, fillColor=8)),
        Rectangle(extent=[-60, 81; 60, 75], style(color=0, fillColor=0)),
        Rectangle(extent=[-60, 67; 60, 61], style(color=0, fillColor=0)),
        Rectangle(extent=[-60, 55; 60, 49], style(color=0, fillColor=0)),
        Polygon(points=[-60, 11; -42, 23; 38, 23; 56, 11; -60, 11], style(
              pattern=0, fillColor=7)),
        Ellipse(extent=[-6, 41; 2, 33], style(color=0, fillColor=0)),
        Ellipse(extent=[-40, -129; 40, -49], style(color=8)),
        Line(points=[0, -90; 26, -58; -2, 37], style(color=0, thickness=4)),
        Text(extent=[-150, -124; 164, -186], string="%name"),
        Line(points=[-100, -90; 100, -91], style(color=0, thickness=2))));
  equation

    connect(Mounting.frame_a, cylinder_a)
      annotation (points=[-1, 130; -110, 130], style(color=0, thickness=2));
    connect(Mounting.frame_b, cylinder_b)
      annotation (points=[21, 130; 110, 130], style(color=0, thickness=2));
    connect(Crank1.frame_a, CrankAngle1.frame_b)
      annotation (points=[-51, -90; -69, -90], style(color=0, thickness=2));
    connect(CrankAngle1.frame_a, crank_a)
      annotation (points=[-91, -90; -110, -90], style(color=0, thickness=2));
    connect(Crank4.frame_b, CrankAngle2.frame_a) annotation (points=[40.5, -85;
           40.5, -90; 59, -90], style(color=0, thickness=2));
    connect(CrankAngle2.frame_b, crank_b)
      annotation (points=[81, -90; 110, -90], style(color=0, thickness=2));
    connect(CylinderInclination.frame_a, cylinder_a) annotation (points=[-61,
          40; -70, 40; -70, 130; -110, 130], style(color=0, thickness=2));
    connect(Crank1.frame_b, Crank2.frame_a) annotation (points=[-29, -90; -10,
          -90; -10, -87], style(color=0, thickness=2));
    connect(Crank3.frame_b, Crank4.frame_a) annotation (points=[25.5, -50; 40.5,
           -50; 40.5, -63], style(color=0, thickness=2));
    connect(Crank3.frame_a, Crank2.frame_b) annotation (points=[3.5, -50; -10,
          -50; -10, -65], style(color=0, thickness=2));
    connect(Crank2.frame_b, Mid.frame_a) annotation (points=[-10, -65; -10, -36;
           -7, -36], style(color=0, thickness=2));
    connect(jointRRP.frame_ia, Rod.frame_a) annotation (points=[42, -16; 67, -16;
           67, -10], style(color=0, thickness=2));
    connect(Mid.frame_b, jointRRP.frame_a) annotation (points=[15, -36; 20, -36;
           20, -22], style(color=0, thickness=2));
    connect(CylinderInclination.frame_b, CylinderTop.frame_a) annotation (
        points=[-39, 40; -30, 40; -30, 59], style(color=0, thickness=2));
    connect(gasForce.flange_a, jointRRP.axis)
      annotation (points=[30, 60; 36, 60; 36, 22], style(color=58));
    connect(jointRRP.bearing, gasForce.flange_b) annotation (points=[28, 22; 28,
           40; 0, 40; 0, 60; 10, 60], style(color=58));
    connect(jointRRP.frame_ib, Piston.frame_b) annotation (points=[42, 16; 51,
          16; 51, 70; 80.5, 70; 80.5, 56.05], style(color=0, thickness=2));
    connect(jointRRP.frame_b, CylinderTop.frame_b) annotation (points=[20, 22;
          20, 30; -10, 30; -10, 100; -30, 100; -30, 81], style(color=0,
          thickness=2));
  end Cylinder_analytic;
end Utilities;
