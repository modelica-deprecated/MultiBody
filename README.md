# MultiBody Library

This library is deprecated since it has been incorporated in a slightly improved form into the Modelica Standard Library, version 2.1.

## Library description

The `MultiBody` library is a free Modelica package providing 3-dimensional mechanical components to model in a convenient way mechanical systems, such as robots, mechanisms, vehicles. This package contains a tutorial of the MultiBody library.


## Current release

Download [MultiBody v1.0 (2004-03-03)](../../archive/v1.0.zip)

#### Release notes

*  [Version v1.0 (2004-03-03)](../../archive/v1.0.zip)
 * This version is not backward compatible to version 0.99. Models generated with previous MultiBody versions are automatically converted to the new release.The incompatible changes are due to improving the efficiency of the library. This required to change function interfaces in MultiBody.Frames: `angularVelocity1`, `angularVelocity2`, `planarRotation`, `axisRotation`, `axesRotations`, `from_T`, `from_T_inv`, `from_Q`. Furthermore, `MultiBody.Frames.Orientation` has changed. As a consequence, all code that accesses objects of this type directly is no longer valid.

*  [Version v0.98 (2003-10-27)](../../archive/v0.98.zip)
 * This version is not backward compatible to the previous MultiBody versions, since the initialization has changed. Parameter "startValuesFixed" is no longer present and is replaced by parameter "initType" (see below). Models generated with previous MultiBody versions are automatically converted to the new release.

## License

This Modelica package is free software and the use is completely at your own risk;
it can be redistributed and/or modified under the terms of the [Modelica License 2](https://modelica.org/licenses/ModelicaLicense2).

## Development and contribution

This library is deprecated and therefore no longer actively developed.
An improved version was incorporated into the Modelica Standard Library and is maintained there.
