package Elementary "Elementary examples to demonstrate various features of the MultiBody library"
extends Modelica.Icons.Library;


annotation( preferedView="info", Documentation(info="<HTML>
<p>
This package contains elementary example models to demonstrate
the usage of the MultiBody library
</p>
<h4>Content</h4>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Model</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Examples.Elementary.DoublePendulum\">DoublePendulum</a></b></td>
      <td> Simple double pendulum with two revolute joints and two bodies.<br>
      <img src=\"../Images/Examples/Elementary/DoublePendulumSmall.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Examples.Elementary.ForceAndTorque\">ForceAndTorque</a></b></td>
      <td> Demonstrates usage of Forces.ForceAndTorque element.<br>
      <img src=\"../Images/Examples/Elementary/ForceAndTorque_small.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Examples.Elementary.FreeBody\">FreeBody</a></b></td>
      <td> Free flying body attached by two springs to environment.<br>
      <img src=\"../Images/Examples/Elementary/FreeBody_small.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Examples.Elementary.InitSpringConstant\">InitSpringConstant</a></b></td>
      <td> Determine spring constant such that system is in steady state
           at given position.<br>
      <img src=\"../Images/Examples/Elementary/InitSpringConstant_small.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Examples.Elementary.LineForceWithTwoMasses\">LineForceWithTwoMasses</a></b></td>
      <td> Demonstrates a line force with two point masses using a
           Joints.Assemblies.JointUPS and alternatively a
           Forces.LineForceWithTwoMasses component.<br>
      <img src=\"../Images/Examples/Elementary/LineForceWithTwoMasses_small.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Examples.Elementary.Pendulum\">Pendulum</a></b></td>
      <td> Simple pendulum with one revolute joint and one body. <br>
      <img src=\"../Images/Examples/Elementary/Pendulum_small.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Examples.Elementary.PendulumWithSpringDamper\">PendulumWithSpringDamper</a></b></td>
      <td> Simple spring/damper/mass system <br>
      <img src=\"../Images/Examples/Elementary/PendulumWithSpringDamper_small.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Examples.Elementary.PointGravity\">PointGravity</a></b></td>
      <td> Two point masses in a point gravity field <br>
      <img src=\"../Images/Examples/Elementary/PointGravity_small.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Examples.Elementary.SpringDamperSystem\">SpringDamperSystem</a></b></td>
      <td> Spring/damper system with a prismatic joint and
           attached on free flying body <br>
      <img src=\"../Images/Examples/Elementary/SpringDamperSystem_small.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Examples.Elementary.SpringMassSystem\">SpringMassSystem</a></b></td>
      <td> Mass attached via a prismatic joint and a spring to the world frame <br>
      <img src=\"../Images/Examples/Elementary/SpringMassSystem_small.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Examples.Elementary.SpringWithMass\">SpringWithMass</a></b></td>
      <td> Point mass hanging on a spring <br>
      <img src=\"../Images/Examples/Elementary/SpringWithMass_small.png\">
      </td>
  </tr>
  <tr><td><b><a href=\"Modelica://MultiBody.Examples.Elementary.ThreeSprings\">ThreeSprings</a></b></td>
      <td> 3-dimensional springs in series and parallel connection<br>
      <img src=\"../Images/Examples/Elementary/ThreeSprings_small.png\">
      </td>
  </tr>
</table>
</HTML>"));
end Elementary;
