# fluxgrapher

This application let’s you upload a jpg or png file with a maximum height of 360px that represents an occulting object in front of a star that has a diameter of 360px. The output of this application is a graph of the relative flux of the star that will be observed when the uploaded objects transits the star at a constant velocity. If the star graphic represents KIC 8462852, then one pixel of the occulting object represents an area of approximately 6100 by 6100 km (given that the object is within the star’s solar system).

### Example output of the app
A relative flux graph corresponding to a transit of the example input file

![Example graph for a triangle that blocks around 4 percent of the light](./www/4percenttriangle_examplegraph.png)

### Example input file
(real size)

![object](./www/fourpercenttriangle.png)

### Used star
(real size)

The used image of the star. This is just a circle with an inner shadow to imitate limb darkening. It is not an actual observation of a star at a given spectrum.

![star](./www/starlimbdarkening.png)




