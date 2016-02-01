
Acknowledgements {#acknowledgements .unnumbered}
================



Introduction
============

Cellular Automata (CA) represent a parallel computing methodology for
modelling complex systems. Well known examples of applications include
the simulation of natural phenomena such as lava and debris flows,
forest fires, agent based social processes such as pedestrian evacuation
and highway traffic problems, besides many others (e.g., theoretical
studies).

Many Cellular Automata software environments and libraries exist.
However, when non-trivial modelling is needed, only non-open source
software are generally available. This is particularly true for eXtended
Cellular Automata (XCA), adopted for simulating phenomena at a
macroscopic point of view, for which only a significant example of non
free software exists, namely the CAMELot Cellular Automata Simulation
Environment.

In order to fill this deficiency in the world of free software, the
`OpenCAL` C Library has been developed. Similarly to CAMELot, it allows
for a simple and concise definition of both the transition function and
the other characteristics of the cellular automaton definition.
Moreover, it allows for both sequential and parallel execution, both on
CPUs and GPUs (thanks to the adoption of the OpenMP and OpenCL APIs,
respectively), hiding most parallel implementation issues to the user.

The library has been tested on both CPUs anf GPUs by considering
different Cellular Automata, including the well known Conwayâ€™s Game of
Life and the SciddicaT XCA debris flows simulation model. Results have
demonstrated the goodness the library both in terms of usability and
performance.

In the present release 1.0 of the library, 2D and 3D cellular automata
can be defined[^1]. The library also offers diverse facilities (e.g. it
provides many pre-defined cellâ€™s neighborhoods), allows to explicate the
simulation main cycle and provides a built in optimization algorithm to
speed up your simulation. Moreover, OpenCAL offers you a built in
interactive 2D/3D visualization system you can use to graphically
represent step by step your simulation based. The visualization system
was developed in OpenGL Compatibility Profile, thus is able to run
everywhere, also on old workstations.

The present manual reports the main usage of the `OpenCAL` library
related to the sequential, OpenMP and OpenCL versions, the library
installation procedure, besides diverse examples of application. In
particular, Chapter \[ch:installation\] deals with OpenCAL download and
installation, while Chapter \[ch:CA\] introduce you to the CA and XCA
computational paradigms. If you already know theese topics, you can skip
this Chapter. Chapter \[ch:opencal\] is about serial CA and XCA
development with OpenCAL, and introduce the different library features
by examples. Chapter \[ch:opencal-omp\] is about the OpenMP-based
parallel version of OpenCAL and also introduces the library by examples.
Chapter \[ch:opencal-cl\] briefly introduces you to General Purpose GPU
programmin with OpenCL and then presents you the OpenCL-based version of
OpenCAL, still by examples. OpenCAL-GL, whihch is the name that
identifies the OpenGL visualization system built into OpenCAL, is
introduced at the end of each of the above Chapters, together with
computational performaces of some of the implemented CA. Eventually,
Chapter \[ch:utility\] ends this user guide by presenting you some
usefull library features that werenâ€™t presented previously, like
reduction functions.

Quick Start
===========

Installation {#ch:installation}
============

The 1.0 release of `OpenCAL`, here presented, is a collection of four
different software libraries. Under the name `OpenCAL` we identify the
serial version of the library. It comes together with two different
parallel implementations based on OpenMP and OpenCL, namely OpenCAL-OMP
and OpenCAL-CL, respectively. Moreover, OpenCAL-GL identifies a general
purpose OpenGL/GLUT visualization library. Many examples are also
included into the distribution.

The library can be obtained as source code from GitHub to be compiled in
your system. You can chose if compiling all the four different
implementations or only some of them, and also if compling the examples.
Some dependencies must be satisfied, depending on what you want to
compile. Libraries can be compiled both statically (as .lib files) and
as shared objects (as .so files). Eventually, you can install headers
and libraries in your system and also uninstall them if no longer
needed.

In the following Sections we will see all the steps needed to obtain the
software and make it working on your computer.

Requirements and dependencies
-----------------------------

In order to compile OpenCAL, you essentially need CMake (version 2.8 or
greater) and an ANSI C compiler (e.g. gcc 4.9 or greater[^2]) installed
in your system. CMake is used to generate the makefiles (or even project
files for several IDEs) to be used to build OpenCAL.

An OpenCL implementation (e.g. by NVIDIA, AMD, Intel) is also needed to
compile OpenCAL-CL. Moreover, still to compile OpenCAL-CL, at least the
3.1 version of CMake is required. Eventually, a GLUT development library
is needed to compile OpenCAL-GL. The following is a dependencies list
for each of the above software libraries:

OpenCAL: 

:   CMake version 2.8 or grater, and a quite new C compiler.

OpenCAL-OMP: 

:   A C compiler supporting at least Open-MP version 2.0[^3].

Open-CL: 

:   CMake version 3.1 or grater and at least one OpenCL implementation
    installed in your system[^4].

OpenCAL-GL: 

:   OpenGL/GLUT headers and libraries [^5];

Eventually, Doxygen and Graphviz are required to build the software
documentation, which provides specific information about libraryâ€™s data
structures and functions.

Obtaining OpenCAL
-----------------

OpenCAL is available as source code you can downoad from GitHub and
build into your own system. We suggest you to download the stable
software release at the following GitHub url:

<https://github.com/OpenCALTeam/opencal/archive/OpenCAL-1.0.zip>

Another (not recommended) option is to dowload the development release.
It can be obtained as compressed archive at
<https://github.com/OpenCALTeam/opencal/archive/master.zip>, or by
*cloning* the Git repository through the following commands:

``` {.bash numbers="none" language="bash"}
user@machine:-$ cd <gitwd>
user@machine:-$ git clone https://github.com/OpenCALTeam/OpenCAL
user@machine:-$ cd opencal
```

Here `<gitwd>` represents the directory in your file system containing
your git respositories. If you donâ€™t have a git working directory, we
suggest you to create one.

Structure of the Distribution Directory
---------------------------------------

The software distribution contains the following files and directories:

AUTHORS - 

:   OpenCAL Authors list;

OpenCAL - 

:   Core and examples code of the *serial* implementation;

OpenCAL-CL - 

:   Core and examples code of the Open-CL-based parallel implementation;

OpenCAL-GL - 

:   Graphic OpenGL/GLUT-based visualization system library and examples;

OpenCAL-OMP - 

:   Core and examples code of the Open-MP-based parallel implementation;

CMakeLists.txt - 

:   CMake configuration file;

cmake\_uninstall.cmake.in - 

:   Uninstall script;

configure.cmake - 

:   File needed by (i.e. included in) CMakeLists.txt;

LICENSE

:   The GNU LGPL licence;

Other minor files - 

:   Other minor files can also be included into the distribution.

### Generating makfiles

Once you have satisfied all necessary dependencies it is time to
generate the makefiles (or the project files or for your development
environment) needed to build the software distribution. CMake needs to
know two paths for this:

1.  The path to the OpenCAL source tree root directory;

2.  The target path for the generated files and compiled binaries.

If these paths are the same, we are in front of an in-tree build,
otherwise of an out-of-tree build. We strongly suggest to do an
out-of-tree build. One of several advantages of out-of-tree builds is
that you can generate files and compile for different development
environments using a single source tree.

To make an out-of-tree build you need to:

1.  Enter the source tree root directory (e.g. `<gitwd>/opencal/`);

2.  Create a directory for the binaries (e.g. `<gitwd>/opencal/build/`)
    and enter into it;

3.  Run CMake using zero or more of the options listed in Table
    \[ch:installation:cmakeoptions\] to control which features will be
    enabled in the compiled library. The current directory is used as
    target path, while the path provided as an argument is used to find
    the source tree.

If you want to build everything (serial and parallel libraries, examples
and documentation), you can use the following commands:

      user@machine:-$ cd <gitwd>/opencal/
      user@machine:-$ mkdir build && cd build
      user@machine:-$ cmake ../ -DBUILD_OPENCAL_SERIAL=ON \
                                -DBUILD_OPENCAL_OMP=ON \
                                -DBUILD_OPENCAL_CL=ON \
                                -DBUILD_OPENCAL_GL=ON \
                                -DBUILD_EXAMPLES=ON \
                                -DBUILD_DOCUMENTATION=ON \
                                -DENABLE_SHARED=ON

Each CMake option corresponds to a target. If you are not interested to
some of them, simply switch off the corresponding option. For instace,
if you set the `ENABLE_SHARED` option to `OFF` (that, indeed, is the
default value), generated makefiles will be set to build static
libraries (.a files under Linux systems) instead of shared objects (.so
files). If you omit a CMake option, the default value will be assumed
(cf. Table \[ch:installation:cmakeoptions\]).

<span>lXl</span> **OPTION** & **EFFECT** & **DEFAULT**\
`BUILD_OPENCAL_SERIAL` & Build the OpenCAL serial version & ON\
`BUILD_OPENCAL_OMP` & Build the OpenCAL-OMP OpenMP parallel version
(OpenMP required) & OFF\
`BUILD_OPENCAL_CL` & Build the OpenCAL-CL OpenCL parallel version
(OpenCL required) &OFF\
`BUILD_OPENCAL_GL` & Build the OpenCAL-GL visualization library (OpenGL
and GLUT required) &OFF\
`BUILD_EXAMPLES` & Build the examples for each OpenCAL version &\
`BUILD_DOCUMENTATION` & Build the HTML based API documentation (Doxygen
and Graphviz required) & OFF\
`ENABLE_SHARED` & Controls whether the library should be compiles as
shared object (.so). If OFF, static objects (.a) will be produced & OFF\

Build and Install/Uninstall
---------------------------

Once makefiles have been produced by CMake, everything is set up and
ready for compiling. To build use the following command:

      user@machine:-$ make -jn

where `n` is the number of cores of your machine you want to use for
speeding up the compilation process.

You can install the compiled objects (libraries and examples - if
enabled during the CMake configuration), headers and API documentation
in the appropriate folders using the following command:

      user@machine:-$ sudo - 
      root@machine:-$ make install

or equivalently, if your user is in the `sudoers` list

      user@machine:-$ sudo make install

By default, files are installed in ... For instance, under Debian, file
are installed in... If you want to change the default settings...

      <QUI BISOGNA SPIEGARE COSA SI DEVE FARE PER CAMBIARE IL TARGET PER IL
      MAKE INSTALL>

If you want to uninstall OpenCAL for some reason, you can simply enter
the build directory and call make with the uninstall target, as in the
following:

      user@machine:-$ sudo make uninstall

Web Page and Bug Reporting
--------------------------

The Web page for OpenCAL is at <http://opencal.telesio.unical.it> and
contains up-to-date news and a list of bug reports.
<span>OpenCAL</span>â€™s GitHub homepage is at
<https://github.com/OpenCALTeam/opencal>. For further information or bug
reports contact
[mailto:opencal@telesio.unical.it](mailto:opencal@telesio.unical.it) or
use the submit an issue at the following url
<https://github.com/OpenCALTeam/opencal/issues>.

When reporting a bug, please include as much information and
documentation as possible. Helpful information would include OpenCAL
version, OpenMP/OpenCL implementation and version used, configuration
options, type of computer system, problem description, and error message
output.

Cellular Automata {#ch:CA}
=================

Cellular Automata (CA) are parallel computing models, whose evolution is
ruled by local rules. They are largely employed in Science and
Engineering for a wide range of problems, especially when classic
methods (e.g., based on differential equations) can not be conveniently
applied. In this Chapter, CA are briefly introduced, together with a
recent extension of them, known as eXtended Cellular Automata (XCA),
which are widely used for the modelling of physical extended systems.

Informal Definition of Cellular Automata {#sec:CAInformaDef}
----------------------------------------

A cellular automaton can be thought as a $d$-dimensional space, called
*cellular space*, subdivided in regular cells of uniform shape and size.
Each cell embeds a *finite automaton*, one of the most simple and well
known computational models, which can assume a finite number of states.
At time $t=0$, cells are in arbitrary states and the CA evolves step by
step by changing the states of the cells at discrete time steps, by
applying the same local rule of evolution, i.e. the cellâ€™s *transition
function*, simultaneously (i.e. in parallel) to each cell of the CA.
Input for the cell is given by the states of a predefined (small) set of
neighboring cells, which is assumed constant in space and time. It is
possible to identify an informal definition of cellular automaton by
simply listing its main properties:

-   It is formed by a $d$-dimensional space (i.e. the *cellular space*),
    partitioned into cells of uniform shape and size (e.g. triangles,
    squares, hexagons, cubes, etc. - see Figure \[fig:cellularspaces\]);

-   The number of cellâ€™s states is finite;

-   The evolution occurs through discrete steps;

-   Each cell changes state simultaneously to each other (i.e. they
    change state concurrently, in parallel) thanks to the application of
    the cellâ€™s *transition function*;

-   The cellâ€™s state transition depends on the states of a set of
    neighboring cells;

-   The evolving cell is called *central cell* and can belong to its
    neighbourhood;

-   The neighboring relationship is local, uniform and invariant over
    time (see Figures \[fig:1Dneighborhood\] and \[fig:2Dneighborhood\]
    for examples of 1D and 2D neighborhoods, respectively).

![Example of cellular spaces: (a) one-dimensional, (b) two-dimensional
with square cells, (c) two-dimensional with hexagonal cells, (d)
three-dimensional with cubic cells.<span
data-label="fig:cellularspaces"></span>](./images/CellularAutomata/cellularspaces){width="12cm"}

![Example of neighborood with radius (a) $r = 1$ and (b) $r
      = 2$ for one-dimensional Cellular Automata. Central cell is
represented in dark gray, while adjacent cells are in light gray. Note
that the central cell can optionally belong to its own
neighborhood.<span
data-label="fig:1Dneighborhood"></span>](./images/CellularAutomata/onedimensional.pdf){width="12cm"}

![Examples of von Neumann (a) and Moore (b) neighboroods for
two-dimensional CA with square cells. Examples of (Moore) neighborhoods
are also shows for hexagonal CA, both for the cases of horizontal (c)
and vertical (d) cells orientation. Central cell is represented in dark
gray, while adjacent cells are in light gray. Note that the central cell
can optionally belong to its own neighborhood.<span
data-label="fig:2Dneighborhood"></span>](./images/CellularAutomata/2Dneighborhoods.png){width="12cm"}

Despite their simple definition, CA can exhibit very interesting complex
global behaviors. Moreover, from a computational point of view, they are
equivalent to Turing Machines. This means, in principle, that everything
that can be computed can also be by means of a cellular automaton
(Churchâ€“Turing thesis). Thanks to their *computational universality*, CA
gained a great consideration inside the Scientific Community and were
employed for solving a great variety of different complex problems.

Formal Definition of Cellular Automata
--------------------------------------

Cellular Automata are formally defined as a quadruple:

$$A = <R,X,Q,\sigma>$$

where:

-   $R = \{i = (i_0,i_1,....,i_{d-1}) \; | \; i_k \in \mathbb{Z} \;\; \forall k =
      0,1,...,d-1\}$ is the set of points, with integer coordinates,
    which defines the $d$-dimensional cellular space;

-   $X = \{\xi_0,\xi_1\,...\xi_{m-1}\}$ is the finite set of $m$
    $d$-dimensional vectors
    $$\xi_j = \{\xi_{j_0},\xi_{j_1},...\xi_{j_{d-1}}\}$$ that define the
    set $$N(X,i) = \{i + \xi_0,i + \xi_1,...,i + \xi_{m-1}\}$$ of
    coordinates of cells belonging the the central cellâ€™s
    neighborhood (i.e. the cell with coordinates $i =
      (i_1,i_2,...i_d)$). In other words, $X$ represents the geometrical
    pattern that specifies the neighbourhood relationship;

-   $Q$ is the finite set of states of the cell;

-   $\sigma : Q^m \rightarrow Q$ is the cellâ€™s transition function.

Some Applications of Cellular Automata
--------------------------------------

CA are particularly suited to model and simulate classes of complex
systems characterized by a large number of interacting elementary
components. The assumption that if a system behaviour is complex, the
model that describes it must necessarily be of the same complexity is
replaced by the idea that its behavior can be described, at least in
some cases, in very simple terms.

Among different fields, fluid-dynamics is one of most important
applications for CA and, in this research branch, many different
CA-based methods can be found in the literature to simulate fluid flows.
For instance, Lattice Gas Automata (LGA) were introduced for describing
the motion and collision of *particles* on a grid and it was shown that
such models can reproduce the main fluid dynamical properties. The
continuum limit of these models leads to the Navier-Stokes equations.
Lattice Gas models can be regarded as microscopic models, as they
describe the motion of fluid particles which interact by scattering. An
advantage of Lattice Gas models is that the simplicity of particles, and
of their interactions, allow for the simulation of a large number of
them, making it therefore possible to observe the emergence of flow
patterns. Furthermore, since they are CA systems, it is possible to
easily run simulations in parallel. A different approach to LGA is
represented by Lattice Boltzmann models in which the state variables can
take continuous values, as they are supposed to represent the density of
fluid particles, endowed with certain properties, located in each cell
(space and time are also discrete, as in lattice gas models). Both
Lattice Gas and Lattice Boltzmann Models have been applied for the
description of fluid turbulence.

Since many complex natural phenomena evolve on very large areas, they
are therefore difficult to be modelled at a microscopic level of
description. Among these, we can find some real flow-type phenomena like
debris and lava flows, as well as floods and pyroclastic flows. Besides
rheological complex behaviour, they generally evolve on complex
topographies, that can even change during the phenomenon evolution, and
are often characterised by branching and rejoining of the flow. In order
to better model such kind of phenomena, an extended notion of Cellular
Automata (eXtended Cellular Automata, described in the next Section),
can represent a valid alternative to classical CA.

eXtended Cellular Automata
--------------------------

As regards the modeling of natural complex phenomena, Prof. Gino
â€˜Miracle Crisciâ€™ and co-workers from University of Calabria (Italy)
proposed a method based on an eXtended notion of CA (XCA), firstly
applied to the simulation of basaltic lava flows in the 80â€™s[^6]. It was
shown that the approach behind XCA can greatly make more straightforward
the modeling of some complex systems.

Informally, XCA, compared to classical CA, are different because of the
following reasons:

-   The cellâ€™s state is decomposed in *substates*, each of them
    representing the set of admissible values of a given characteristic
    assumed to be relevant for the modeled system and its evolution
    (e.g., lava temperature, lava thickness, etc, in the case of ca lava
    flow model). The set of states for the cell is simply obtained as
    the Cartesian product of the considered substates.

-   As the cellâ€™s state can be decomposed in substates, also the
    transition function can be split into *elementary processes*, each
    of them representing a particular aspect that rules the dynamic of
    the considered phenomenon. In turn, *elementary processes* can be
    split into *local interactions*, which refer to rules that deal with
    interactions among substates of the cell with neighbor ones (e.g.,
    mass exchange with neighbours) and *internal transformations*,
    defined as the changes in the values of the substates due only to
    interactions among substates inside the cell (e.g. the solidiÂ¢cation
    of the lava inside the cell due to the substate â€˜lava temperatureâ€™).

-   A set of *parameters*, commonly used to characterize the dynamic
    behaviors of the considered phenomenon, can be defined.

-   Global operations can also be allowed (e.g. to model external
    influences that can not easily be described in terms of local
    interactions, or to perform reductions over the whole, or a subset
    of, the cellular space). Such operations go under the name of
    *steering*.

### Formal Definition of eXtended Cellular Automata

Formally, a XCA is defined as a 7-tuple:

$$A = <R,X,Q,P,\sigma,\Gamma,\gamma>$$

where:

-   $R$ is the $d$-dimensional cellular space.

-   $X$ is the geometrical pattern that specifies the neighbourhood
    relationship; $m = |X|$ represent the number of elements in the set
    $X$, i.e. the number of neighbors for the central cell.

-   $Q = Q_0 \times Q_1 \times....\times Q_{n-1}$ is the set of cellâ€™s
    states, expressed as Cartesian product of the $n$ considered
    *substates* $Q_0 \times Q_1 \times....\times Q_{n-1}$.

-   $P = {p_0,p_1,....,p_{p-1}}$ is the set of CA *parameters*.They can
    allow a fine tuning of the XCA model, with the purpose of
    reproducing different dynamical behaviours of the phenomenon
    of interest.

-   $\sigma : Q^m \rightarrow Q$ is the cellâ€™s transition function. It
    is splitted in $s$ *elementary processes*, $\sigma_0,\sigma_1, ...,
      \sigma_{s-1}$, each one describing a particular aspect ruling the
    dynamic of the considered system.

-   $\Gamma \subseteq R$ is the region over which the steering function
    is applied.

-   $\gamma: Q^{|\Gamma|} \rightarrow Q^{|\Gamma|} \times
      \mathbb{R}$ is the (global) steering functions.

In the next Chapters, some examples of XCA will be presented. Their
implementations in OpenCAL will also be described, both in serial
(Chapter \[ch:opencal\]) and in parallel (Chapters \[ch:opencal-omp\]
and \[ch:opencal-cl\]).

OpenCAL {#ch:opencal}
=======

With OpenCAL (without any suffix) we identify the sequential version of
the OpenCAL software library, which runs on just a single core of your
CPU, and represents the basis for the other parallel versions, namely
OpenCAL-OMP, based on OpenMP, and OpenCAL-CL, based on OpenCL (and thus
able to run on GPUs). Moreover, OpenCAL allows for some *unsafe
operations*, which can significantly speed up your application. Such
unsafe operations can also be found in the OpenMP version, while they
are not currently available in OpenCAL-CL.

In the following sections, we will introduce OpenCAL by examples. In the
first part of the Chapter, we will deal with the OpenCALâ€™s *safe mode*,
while in the last one, we will go deep inside OpenCAL, discussing
*unsafe mode* operations.

Conwayâ€™s Game of Life {#sec:cal_life}
---------------------

In order to introduce you to Cellular Automata development with OpenCAL,
we start this section by implementing the Conwayâ€™s Game of Life. It
represents one of the most simple, yet powerful examples of Cellular
Automata, devised by mathematician John Horton Conway in 1970.

The Game of Life can be thought as an infinite two-dimensional
orthogonal grid of square cells, each of which is in one of two possible
states, *dead* or *alive*. Every cell interacts with the eight adjacent
neighbors [^7] belonging to the Moore neighborhood. At each time step,
one of the following transitions occur:

1.  Any live cell with fewer than two alive neighbors dies, as if
    by loneliness.

2.  Any live cell with more than three alive neighbors dies, as if
    by overcrowding.

3.  Any live cell with two or three alive neighbors lives, unchanged, to
    the next generation.

4.  Any dead cell with exactly three live neighbors comes to life.

The initial configuration of the system specifies the state (dead or
alive) of each cell into the cellular space. The evolution of the system
is thus obtained by applying the above rules (which define the cellâ€™s
transition function) simultaneously to every cell in the cellular space,
so that each new configuration is function of the one at the previous
step. The rules continue to be applied repeatedly to create further
generations. For more details on the Game of Life, please check
Wikipedia at the URL
<http://en.wikipedia.org/wiki/Conway's_Game_of_Life>.

![OpenCALâ€™s 2D cellular space and Moore neighborhood. Cells are
individuated by a couple of matrix-style integer coordinates $(i, j)$,
where $i$ represents the row and $j$ the column. Cell (0,0) is the one
located at the upper-left corner. Moore neighborhood is represented in
gray scale, with the central cell highlighted in dark gray. Neighboring
cells can also be indexed by the integer subscript shown within the
cell. Cells indices are implicitly assigned by OpenCAL, both in the case
of predefined and custom neighborhoods. In the first case, indices can
not be modified, while in the second case, indices are assigned
progressively in an automatic way each time a new neighbor is added to
the CA by means of the `calAddNeighbor2D()` function.<span
data-label="fig:LifeNeighborhood"></span>](./images/OpenCAL/LifeNeighborhood.png){width="5cm"}

The formal definition of the Life CA is reported below.

$$Life = < R, X, Q, \sigma >$$

where:

-   $R$ is the set of points, with integer coordinates, which defines
    the 2-dimensional cellular space. The generic cell in $R$ is
    individuated by means of a couple of integer coordinates $(i, j)$,
    where $0 \leq i < i_{max}$ and $0 \leq j < j_{max}$. The first
    coordinate, $i$, represents the row, while the second, $j$,
    the column. The cell at coordinates $(0,0)$ is located at the
    top-left corner of the computational grid (cf.
    Figure \[fig:LifeNeighborhood\]).

-   $X = \{(0,0), (-1, 0), (0, -1), (0, 1), (1, 0), (-1,-1), (1,-1),
      (1,1), (-1,1)\}$ is the Moore neighborhood relation, a geometrical
    pattern which identifies the cells influencing the state transition
    of the central cell. The neighborhood of the generic cell of
    coordinate $(i, j)$ is given by $$N(X, (i, j)) =$$
    $$= \{(i, j)+(0,0), (i, j)+(-1, 0), \dots, (i, j)+(-1,1)\} =$$
    $$= \{(i, j), (i-1, j), \dots, (i-1,j+1)\}$$ Here, a subscript
    operator can be used to index cells belonging to the neighbourhood.
    Let $|X|$ be the number of elements in X, and $n \in
      \mathbb{N}$, $0 \leq n < |X|$; the notation

    $$N(X, (i, j), n)$$

    represents the $n^{th}$ neighbourhood of the cell $(i,j)$. Thereby,
    $N(X, (i, j), 0) = (i, j)$, i.e. the central cell, $N(X, (i, j), 1)
      = (i-1, j)$, i.e. the first neighbour, and so on (cf.
    Figure \[fig:LifeNeighborhood\]).

-   $Q = \{0, 1\}$ is the set of cellâ€™s states.

-   $\sigma : Q^9 \rightarrow Q$ is the deterministic cell
    transition function. It is composed by one elementary process, which
    implements the previously above mentioned transition rules.

The program below shows a simple Game of Life sequential implementation
in C with OpenCAL. As you can see, even if Listing \[lst:cal\_life\] is
very short, it completely defines the Conwayâ€™s Game of Life CA and
performs a simulation (actually, only one computational step in this
example).

In order to use OpenCAL, you need to include some header files (lines
3-5). Specifically, `cal2D.h` (line 3) allows you to define the CA
object (line 9) and the related substate (line 10), while `cal2DRun.h`
(line 5) allows you to define a CA simulation object (line 11), needed
to run the CA model. The `cal2DIO.h` header file (line 4) provides you
some basic input/output functions for reading/writing substates from/to
file.

While statements at lines 9-11 just declare the required objects, they
are defined later in the `main` function. In particular, the life CA
object is defined at line 29 by the `calCADef2D()` function. The first 2
parameters define the CA dimensions (the number of rows and columns,
respectively), while the third parameter defines the neighbourhood
pattern. Here, the predefined Moore neighborhood is selected (cf. Figure
\[fig:LifeNeighborhood\]), among those provided by OpenCAL. See Listings
\[lst:CALNeighborhood2D\] and \[lst:CALNeighborhood3D\] for a list of
OpenCALâ€™s predefined 2D and 3D neighborhoods, respectively. Custom
neighborhoods can also be defined by means of the `calAddNeighbor2D()`
function. In both cases, indices are assigned progressively, starting
from 0, each time a new cell is added to the neighborhood.

The fourth parameter specifies the boundary conditions. In this case,
the CA cellular space is considered as a torus, with cyclic conditions
at boundaries. The last parameter allows you to specify if your model
has to use the so called *active cells optimization*, that is able to
restrict the computation to only *non-stationary cells*. In this case,
no optimization is considered.

      struct CALModel2D* calCADef2D (
        int rows,
        int columns,
        enum CALNeighborhood2D CAL_NEIGHBORHOOD_2D,
        enum CALSpaceBoundaryCondition CAL_TOROIDALITY,
        enum CALOptimization CAL_OPTIMIZATION
      )

The complete definition of `calCADef2D()` is provided in Listing
\[lst:calCADef2D\], here reported together with few other OpenCAL key
functions and data types. In particular, the `CALNeighborhood2D` enum
type (Listing \[lst:CALNeighborhood2D\]) allows you to select one of the
square or hexagonal predefined neighbourhoods, or a custom
neighbourhood, whose pattern must be defined in the application. In
particular, `CAL_VON_NEUMANN_NEIGHBORHOOD_2D` corresponds to the von
Neumann neighbouring pattern, `CAL_MOORE_NEIGHBORHOOD_2D` to the Moore
neighbouring pattern, `CAL_HEXAGONAL_NEIGHBORHOOD_2D` to the hexagonal
neighbouring pattern, and `CAL_HEXAGONAL_NEIGHBORHOOD_ALT_2D` to the
alternative hexagonal neighbouring pattern (cf. Figure
\[fig:2Dneighborhood\], Section \[sec:CAInformaDef\]). As regards 3D
neighbourhoods patterns, they are defined by means of the
`CALNeighborhood3D` enum type (Listing \[lst:CALNeighborhood3D\]). Here,
we can find the 3D equivalent versions of the von Neumann and Moore
neighbourhoods, while hexagonal neighbourhoods are (obviously) not
defined. Custom neighbourhoods will be discussed later in Section
\[sec:CustomNeiughbourhoods\]. Similarly, the
`CALSpaceBoundaryCondition` enum type (Listing
\[lst:CALSpaceBoundaryCondition\]) allows you to set cyclicality
condition at boundaries. Eventually, the `CALOptimization` enum type
(Listing \[lst:CALOptimization\]) allows you to consider the *active
cells optimization*, discussed later in this Chapter.

      enum CALNeighborhood2D { 
        CAL_CUSTOM_NEIGHBORHOOD_2D,
        CAL_VON_NEUMANN_NEIGHBORHOOD_2D,
        CAL_MOORE_NEIGHBORHOOD_2D,
        CAL_HEXAGONAL_NEIGHBORHOOD_2D,
        CAL_HEXAGONAL_NEIGHBORHOOD_ALT_2D 
    };

      enum CALNeighborhood3D {
        CAL_CUSTOM_NEIGHBORHOOD_3D,
        CAL_VON_NEUMANN_NEIGHBORHOOD_3D,
        CAL_MOORE_NEIGHBORHOOD_3D
    };

      enum CALSpaceBoundaryCondition{
        CAL_SPACE_FLAT = 0,         
        CAL_SPACE_TOROIDAL
      };

      enum CALOptimization{
        CAL_NO_OPT = 0,
        CAL_OPT_ACTIVE_CELLS        
      };

The CA simulation object is defined at line 30 by the `calRunDef2D()`
function. The first parameter is a pointer to a CA object (`life` in our
case), while the second and third parameters specify the initial and
last simulation step, respectively. In this case, we just perform one
step of computation, being both the first and last step set to 1. The
last parameter allows you to specify the substate update policy. It can
be implicit or explicit (Listing \[lst:CALUpdateMode\]). In the first
case, OpenCAL does substatesâ€™ updates for you, while in the second case
the substatesâ€™ updates is your responsibility. Note that, in case
implicit update policy is applyied, all the CA substates are updated
after the execution of each elementary process composing the CA
transition function. We will discuss update policies later in this
Chapter. The complete definition of `calRunDef2D()` is provided in
Listing \[lst:calRunDef2D()\]. The `CALUpdateMode` type (Listing
\[lst:CALUpdateMode\]) enumerates possible update policies.

      struct CALRun2D* calRunDef2D (
        struct CALModel2D* ca2D,
        int initial_step,
        int final_step,
        enum CALUpdateMode UPDATE_MODE
      )	

      enum CALUpdateMode {
        CAL_UPDATE_EXPLICIT = 0,
        CAL_UPDATE_IMPLICIT
      };

Line 33 allocates memory and registers the `Q` substate to the `life`
CA, while line 36 adds an elementary process to the cell transition
function. The `calAddSubstate2Di()` function is very simple and
self-explanatory. At the contrary, `calAddElementaryProcess2D()` must be
discussed more in detail. It takes the handle to the CA model to which
the elementary process must be attached and a pointer to a callback
function, that defines the elementary process itself. In our example, we
specified `life_transition_function` as second parameter, being it the
name of a developer-defined function that you can find at lines 14-24.
As you can see, the elementary process callback returns `void`.
Moreover, it takes a pointer to a CA object as first parameter, followeb
by a couple of integers, representing the coordinates of the generic
cell in the CA space. This is the function prototype which is common to
each elementary process. Note that, each elementary process is applyed
by OpenCAL simultaneously to each cell of the cellular space in a
computational step [^8]. However, this is completely transparent to the
user, so that he/she can concentrate his/her effort on the definition of
single cell behaviour.

When the user is going to implement an elementary process, by defining
its callback function, he/she can rely on a set of OpenCAL functions
that allow to get the substates values of both the central and the
neighbouring cells, and to update the substates values of the central
cell. In the specific case of the Game of Life, we used the
`calGet2Di()` function to get the central cellâ€™s value of the substate
`Q` (remember that the central cell is identified by the coordinates (i,
j), coming from the callback parameters), the `calGetX2Di()` function to
get the value of the n-th neighbourâ€™s substate `Q`, and the
`calSet2Di()` function to update the value of the substate `Q` for the
central cell. In the Game of Life example, we defined just one
elementary process, that therefore represents the whole cell transition
function. However, as we will see later, many elementary processes can
be defined in OpenCAL by simply calling the
`calAddElementaryProcess2D()` function many times. If you define more
than one elementary process, they will be executed in the order they are
added to the CA.

The `calInitSubstate2Di()` function at line 39 sets the whole substate
`Q` to the value 0, i.e. the value of the substate `Q` is set to 0 in
each cell of the cellular space. The following lines, from 42 to 46, set
the value of the substate `Q` for some cells to 1, in order to define a
well known *glider* pattern. In this case, we provided the cells
coordinates as the third and fourth parameters. In this way, we define
the initial condition of the system direcly inside the `main` function.
However, as we will see later in this Chapter, such kind of
initialization can be performed by means of a specific function.

The `calSaveSubstate2Di()` function (line 49) saves the substate `Q` to
file, while the `calRun2D()` function (line 52) enters the simulation
loop (actually, only one computational step in this example), and
returns to the `main` function when the simulation is complete. The
`calSaveSubstate2Di()` is thus called again at line 55 to save the new
(last) configuration of the CA (represented by the only defined substate
`Q`) to file, while the last two functions at lines 58 and 59 release
previously allocated memory. The `return` statement at line 61 ends our
first example.

Figures \[fig:life\_0000\] and \[fig:life\_LAST\] show the initial and
final configuration of Game of Life as implemented in Listing
\[lst:cal\_life\], respectively.

![Initial configuration of Game of Life, as implemented in Listing
\[lst:cal\_life\].<span
data-label="fig:life_0000"></span>](./images/OpenCAL/life_0000){width="7cm"}

![Final configuration of Game of Life (actually, just one step of
computation), as implemented in Listing \[lst:cal\_life\].<span
data-label="fig:life_LAST"></span>](./images/OpenCAL/life_LAST){width="7cm"}

OpenCAL statement convention
----------------------------

As you can easily see from a rapid sight to the source code, all the
OpenCAL statements are characterized by a prefix and a suffix. All the
data types have the `CAL` prefix, and an optional suffix that identifies
the CA dimension (e.g. 2D for a two-dimensional model) and the basic
type. For instance, in the case of the Lifeâ€™s `Q` substate, the 2Di
suffix of the `CALSubstate2Di` type specifies that it is a
two-dimensional substate in which each element is of integer type.

More in detail, OpenCAL comes with three different basic numeric types,
which are in lowercase (besides the prefix):

-   `CALbyte`, corresponding to the `char` C data type;

-   `CALint`, corresponding to the `int` C data type;

-   `CALreal`, corresponding to the `long double` C data type;

while the possible substates types are:

-   `CALSubstate2Db`, corresponding to a `CALbyte` based substate;

-   `CALSubstate2Di`, corresponding to a `CALint` based substate;

-   `CALSubstate2Dr`, corresponding to a `CALreal` based substate.

Also the OpenCAL constants have a prefix, namely the `CAL_` one, followd
by at least one uppercase keyword. In case of more kewords, they are
separated by the `_` character. Eventually, all the OpenCAL functions
start with the `cal` suffix, followed by at least one capitalized
keyword, and end with a suffix specifying the CA dimension and the basic
datatype (e.g. the suffix `2Dr` is for a two-dimensionale real
substate).

Custom Neighbourhoods {#sec:CustomNeiughbourhoods}
---------------------

In the Game of Life example, we used the predefined Moore neighbourhood.
As you already know, OpenCAL also provides other 2D and 3D predefined
neighbourhoods. Furthermore, it allows for the definition of custom
neighbourhood patterns (cf. Listings \[lst:CALNeighborhood2D\] and
\[lst:CALNeighborhood3D\]).

      struct CALCell2D*  calAddNeighbor2D(
          struct CALModel2D* ca2D,          // pointer to a 2D CA object
          int i,                            // row coordinate
          int j                             // column coordinate
      );

      struct CALCell3D*  calAddNeighbor3D(
          struct CALModel3D* ca3D,          // pointer to a 3D CA object
          int i,                            // row coordinate
          int j,                            // column coordinate
          int k                             // slice coordinate
      );

In order to define a custom neighbourhood pattern, you need to specify
`CAL_CUSTOM_NEIGHBORHOOD_2D` (or `CAL_CUSTOM_NEIGHBORHOOD_3D` in case of
a 3D CA) as the third parameter of the `calCADef2D()` function
(`calCADef3D()` for a 3D CA) (cf. Listing \[lst:calAddNeighbor2D-3D\]).
Doing this, you will start with an empty neighbouring pattern. Then call
the `calAddNeighbor2D()` (`calAddNeighbor3D()` for 3D CA) function to
add a cell to the pattern.

      // ...
      int main ()
      {
        // define of the life CA and life_simulation simulation objects
        life = calCADef2D (8, 16, CAL_MOORE_NEIGHBORHOOD_2D, CAL_CUSTOM_NEIGHBORHOOD_2D , CAL_NO_OPT );
        //...
        
        //add neighbors of the Moore neighborhood
        calAddNeighbor2D(life,   0,   0); // neighbor 0 (central cell)
        calAddNeighbor2D(life, - 1,   0); // neighbor 1
        calAddNeighbor2D(life,   0, - 1); // neighbor 2
        calAddNeighbor2D(life,   0, + 1); // neighbor 3
        calAddNeighbor2D(life, + 1,   0); // neighbor 4
        calAddNeighbor2D(life, - 1, - 1); // neighbor 5
        calAddNeighbor2D(life, + 1, - 1); // neighbor 6
        calAddNeighbor2D(life, + 1, + 1); // neighbor 7
        calAddNeighbor2D(life, - 1, + 1); // neighbor 8

        //...
      }

Listing \[lst:CustomMooreExample\] shows an example of how a custom
neighbourhood pattern can be built for the Game of Life CA described
above. In particular, the Moore neighburhood is built by using a
sequence of nine calls to the `calAddNeighbor2D()` function. The first
time the function is called, it adds the relative coordinates (0,0) to
the neighbouring pattern. This first set of coordinates recerives the
subscript identifier 0 and therefore can be used later to refer the
central cell. For instance, when you call `calSet2Di(life,Q,i,j,0);`
(see e.g. line 23, Listing \[lst:cal\_life\]), the relative coordinates
of the neighbor 0 (specified as last parameters), i.e. (0,0), are added
to the coordinates of the cells the elementary process is applying to,
i.e. (i,j) (cf. second and third to last parameters), by obtaining the
cell (i,j) itself, which correspond to the central cell by definition.
The subsequent calls to `calAddNeighbor2D()` add further couples of
coordinates to the neighbouring pattern, by progressively assigning an
integer subscript identifier to each of them.

Eventually, note that you are free to start from a predefined
neighbourhood. For instance, let still consider the above Game of Life
example; you can enrich the Moore neighbourhood pattern by simply
specifying the value `CAL_MOORE_NEIGHBORHOOD_2D` as parameter for the
`calCADef2D` function) and then add further neighbours by calling
`calAddNeighbor2D()` as meny times the as the number of cells you want
to add is.

SciddicaT {#sec:sciddicaT}
---------

In the previous section we illustrated an OpenCAL implementation of a
simple cellular automaton, namely the Conwayâ€™s Game of Life. Here, we
will deal with a more complex example concerning the implementations of
the SciddicaT Cellular Automata model for landslide simulation.
Different versions will be presented, ranging from a naive to a fully
optimized implementation.

Sciddica is a family of two-dimensional XCA (eXtended Cellular Automata
- see Chapter \[ch:CA\]) debris flow models, successfully applied to the
simulation of many real cases, such as the 1988 Mt. Ontake (Japan)
landslide and the 1998 Sarno (Italy) disaster. An oversimplified
toy-version of Sciddica (SciddicaT in the following) was here considered
to be implemented in `OpenCAL`, and its application to the 1992 Tessina
(Italy) landslide shown.

SciddicaT considers the surface over which the phenomenon evolves as
subdivided in square cells of uniform size. Each cell changes its state
by means of the transition function, which takes as input the state of
the cells belonging to the von Neumann neighborhood. It is formally
defined as:

$$SciddicaT = < R, X, Q , P, \sigma  >$$

where:

-   $R$ is the set of points, with integer coordinates, which defines
    the 2-dimensional cellular space over which the phenomenon evolves.
    The generic cell in $R$ is individuated by means of a couple of
    integer coordinates $(i, j)$, where $0 \leq i < i_{max}$ and
    $0 \leq j < j_{max}$. The firt coordinate, $i$, represents the row,
    while the second, $j$, the column. The cell at coodinates $(0,0)$ is
    located at the top-left corner of the computational grid.

-   $X = \{(0,0), (-1, 0), (0, -1), (0, 1), (1, 0)\}$ is the von Neumann
    neighborhood relation (cf. Figure \[fig:2Dneighborhood\]), a
    geometrical pattern which identifies the cells influencing the state
    transition of the central cell. The neighborhood of the generic cell
    of coordinate $(i, j)$ is given by $$N(X, (i, j)) =$$
    $$= \{(i, j)+(0,0), (i, j)+(-1, 0), (i, j)+(0, -1),
    (i, j)+(0, 1), (i, j)+(1, 0)\} =$$
    $$= \{(i, j), (i-1, j), (i, j-1), (i, j+1), (i+1, j)\}$$

    Here, a subscript operator can be used to index cells belonging to
    the neighbourhood. Let $|X|$ be the number of elements in X, and
    $n \in
    \mathbb{N}$, $0 \leq n < |X|$; the notation

    $$N(X, (i, j), n)$$

    represents the $n^{th}$ neighbourhood of the cell $(i,j)$. Thereby,
    $N(X, (i, j), 0) = (i, j)$, i.e. the central cell,
    $N(X, (i, j), 1) = (i-1, j)$, i.e. the first neighbour, and so on.

-   $Q$ is the set of cell states. It is subdivided in the following
    substates:

    -   $Q_z$ is the set of values representing the topographic
        altitude (i.e. elevation);

    -   $Q_h$ is the set of values representing the debris thickness;

    -   $Q_o^4$ are the sets of values representing the debris outflows
        from the central cell to the neighboring ones.

    The Cartesian product of the substates defines the overall set of
    state $Q$:

    $$Q = Q_z \times Q_h \times Q_o^4$$ so that the cell state is
    specified by the following sixtuple:

    $$q = (q_z, q_h, q_{o_0}, q_{o_1}, q_{o_2}, q_{o_3})$$ In
    particular, $q_{o_0}$ represents the outflows from the central cell
    towards the neighbour 1, $q_{o_1}$ the outflow towards the neighbour
    2, and so on.

-   $P$ is set of parameters ruling the CA dynamics:

    -   $p_\epsilon$ is the parameter which specifies the thickness of
        the debris that cannot leave the cell due to the effect of
        adherence;

    -   $p_r$ is the relaxation rate parameter, which affects the size
        of outflows (cf. section above).

-   $\sigma : Q^5 \shortrightarrow Q$ is the deterministic cell
    transition function. It is composed by two elementary processes,
    listed below in the same order they are applied:

    -   $\sigma_1 : (Q_z \times Q_h)^5 \times p_\epsilon \times
          p_r\shortrightarrow Q_o^4$ determines the outflows from the
        central cell to the neighboring ones by applying the
        *minimization algorithm of the differences*. In brief, a
        preliminary control avoids outflows computation for those cells
        in which the amount of debris is smaller or equal to
        $p_\epsilon$, acting as a simplification of the
        adherence effect. Thus, by means of the minimization algorithm,
        outflows $q_o(0,m) \; (m=0,\ldots,3)$ from the central cell
        towards its four adjecent cells are evaluated, and the $Q_o^4$
        substates accordingly updated. Note that, $q_o(0,0)$ represents
        the aoutflow from the central cell towards the neighbour 1,
        $q_o(0,1)$ the aoutflow towards the neighbour 2, and so on. In
        general, $q_o(0,m)$ represnets the outflows from the central
        cell towards the $n=(m+1)^{th}$ neighbouring cell. Eventually, a
        relaxation rate factor, $p_r \in \; ]0,1]$, is considered in
        order to obtain the local equilibrium condition in more than one
        CA step. This can significantly improve the realism of model as,
        in general, more than one step may be needed to displace the
        proper amount of debris from a cell towards the adjacent ones.
        In this case, if $f(0,m) \; (i=0, \ldots, 3)$ represent the
        outgoing flows towards the 4 adjacent cells, as computed by the
        minimization algorithm, the resulting outflows are given by
        $q_o(0,m)=f(0,m) \cdot p_r \; (i=0, \ldots, 3)$.

    -   $\sigma_2: Q_h \times (Q_o^4)^4 \shortrightarrow Q_h$ determines
        the value of debris thickness inside the cell by considering
        mass exchange in the cell neighborhood:
        $h'(0) = h(0) + \sum_{m=0}^3
          (q_o(0,m) - q_o(m,0))$. Here, $h'(0)$ is the new debris
        thickness inside the cell, while $q_o(m,0)$ represents the
        inflow from the $n=(m+1)^{th}$ neighbouring cell. No parameters
        are involved in this elementary process.

In the following Listing \[lst:cal\_sciddicaT\], an OpenCAL
implementation of SciddicaT is shown.

As for the case of Game of Life, the CA model and the simulation objects
are declared as global variables (lines 22 and 35, respectively), and
defined later into the main function (lines 147 and 148, respevctively).
As you can see, the 2D cellular space is a grid of `ROWS` rows times
`COLS` columns cells, corresponding to $i_{max}$ and $j_{max}$ of the
formal definition, respectively (cf. lines 10-11), while the von Neumann
neighbourhood is adopted. The cellular space is still toroidal, as in
Life, and no optimization is considered. Regarding the simulation
object, a total of `STEPS` steps (i.e. 4000 steps - cf. line 14) are
set, and implicit substates updating considered.

Substates and parameters are grouped into two different C structures
(lines 24-28 and 30-33, respectively). Substates are therefore bound to
the CA context by means of the `calAddSubstate2Dr()` function (lines
155-160), as well as elementary processes are defined as collback
functions by means of the `calAddElementaryProcess2D()` function (lines
151-152).

The topographic altitude and debris thickness substates are initialized
from files through the `calLoadSubstate2Dr()` function (lines 163-164),
while the remaining initial state of the CA is set by means of the
`calRunAddInitFunc2D()` function. It registers the
`sciddicaT_simulation_init()` callback, whic is executed once before the
execution of the simulation loop, in which the elementary processes are
applied to the whole set of cells of the cellular space. Such a callback
function must return void and take a pointer to a simulation obect as
parameter. Differently to an elementary process, that can only access
state values of cells belonging to the neighbourhood, this function can
perform global operations on the whole cellular space. In the specific
case of the SciddicaT model, the `sciddicaT_simulation_init()` function
(lines 104-130) sets the values of all the outflows from the central
cell to its neighbours to zero, by means of the function
`calInitSubstate2Dr()` (lines 110-113). Moreover, it sets the values of
the P.r and P.epsilon parameters (lines 116-117) and initializes the
debris flow source by simply subtracting the sourceâ€™s debris thickness
to the topographic altitude. For this purpose, a nested double for is
executed to check the debris thickness in each cell of the cellular
space. Here, the `sciddicaT->rows` and `sciddicaT->cols` members of the
CA object are used, which represent the cellular speceâ€™s numbers of rows
and columns, respectively. Still, the `calGet2Dr()` and `calSet2Dr()`
functions are here employed to read/update substatesâ€™ values inside the
cells.

Line 168 defines a *steering* callback by the
`calRunAddSteeringFunc2D()` function. Steering is executed at the end of
each computational step (i.e. after all the elementary processe have
been applied to each cell of the cellular space), and can perform global
operations over the cellular space. In this case, the
`sciddicaT_simulation_init()` callback is registered; it must return
void and takes a pointer to a simulation object as function parameter.
It simply reset (to zero) the outflows everywere through the
`calInitSubstate2Dr()` function.

The function `calRun2D()` (line 171) enters the OpenCAL simulation loop,
which exectues a totoal of 4000 steps (cf. lines 14 and 148).
Eventually, the final debris flow path is saved to file by means of the
`calSaveSubstate2Dr()` function (line 176) and previously allocated
memery is released (lines 179-180).

As regards the elementary processes, the first one, $\sigma_1$, is
defined at lines 38-88, while the second, $\sigma_2$, at lines 91-101.
In both cases, the `calGet2Dr()` `calGetX2Dr()` functions are employed
to get substesâ€™ values for the central cell and its neighbours,
respectively. Moreover, the `calSet2Dr()` function, updates the central
cellâ€™s state.

Figure \[fig:sciddicaT\] shows the SciddicaT simulation of the 1992
Tessina (Italy) landslide. Both the initial landslide source and the
final flow path configruation are shown.

![SciddicaT simulation of the 1992 Tessina (Italy) landslide.
Topographic altitudes are represented in gray scale. Black represents
the lower altitude, while the white color is used for the highest
elevation in the study area. Debris thickness is represented with
colours ranging from red (for lower values) to yellow (for higher
values). (a) Initial configuration. (b) Final debris flow path. Note
that the graphic output was generated by using the `cal_sciddicaT-glut`
application, that implements the SciddicaT model and provides a minimal
visualization system. You can find it in the examples directoy.<span
data-label="fig:sciddicaT"></span>](./images/OpenCAL/sciddicaT){width="12cm"}

As regards computational preformace, the simulation shown in Figure
\[fig:sciddicaT\] was executed on a Intel Core i7-4702HQ CPU @ 2.20GHz
by exploiting only a single core. The simulation lasted a total of 172
seconds for executing a total of 4000 compuational steps.

Figure \[fig:opencal\_main\_loop\] shows the OpenCAL main loop. Before
entering the loop, if defined, the init function is executed.
Afterwards, while the current step is lower or equal to the final step
of computation (or this latter is set to `CAL_RUN_LOOP`), elementary
processes are executed concurrently[^9]. In this cycle, substates are
updated after each elementary process has been applyed, while just
before the end of the computational step, if defined, the steering
function is executed. At the end of the computational step, a stop
condition is checked, which can stop the simulation before the last step
is reached. In order to define such a stop condition, the user can use
the `stopCondition()` function, which registers a callback in which the
stop condition can be defined.

![OpenCAL main loop chart.<span
data-label="fig:opencal_main_loop"></span>](./images/OpenCAL/opencal_main_loop){width="9.5cm"}

SciddicaT with active cells optimization {#sec:sciddicaT_active}
----------------------------------------

Here we present a computationally improved version of SciddicaT, which
takes advantage of the built-in OpenCAL active cells optimization. As
stated above, this optimization is able to restrict computation to a
subset of cells which are actually involved in computation, by
neglecting those cells for which is sure they will not change state to
the next step (stationary cells).

In the case of SciddicaT, only cells containing debris and their
neighbours can change state to the next step, as they can be interested
in mass variation due to outflows and inflows. At the beginning of the
simulation, we can simply initialize the set of active cells to those
cells containing debris (i.e. those cells forming the initial landslide
source). Moreover, we can add to this set new cells or remove some ones
from it. Specifically, if an outflow is computed from an active cell
towards a neighbouring non-active cell, this latter can be added to the
set of active cells and considered for state change by the remaining
elementary processes in the current step of computation[^10] (if any),
or by the next computational step. Similarly, if a given active cell
looses a sufficient amount of debris, it can be eliminated from the set
of active cells. In the case of SciddicaT, this appens when its
thickness becomes lower than or equal to a given threshold (i.e.
$p_\epsilon$).

In order to account for these processes, we have to slightly revise the
SciddicaT definition. In particular we have to add the set of active
cells, A. The optimized SciddicaT model is now defined as

$$SciddicaT = < R, A, X, Q , P, \sigma >$$ where $A \subseteq R$ is the
set of active cells, while the other components are defned as before.
The transition function is now defined as:

$$\sigma : A \times Q^5 \shortrightarrow Q \times A$$ denoting that it
is applied to only the cells in $A$ and that it can add/remove active
cells. More in detail, the $\sigma_1$ elementary process has to be
modified, as it can activate new cell. Moreover, a new elementary
process, $\sigma_3$, has to be added in order to remove cells that
cannot produce outflows during the next computational step due to the
fact that their debris thickness is negligible. The new sequence of
elementary processes is listed below, in the same order they are
applied.

-   $\sigma_1 : A \times (Q_z \times Q_h)^5 \times p_\epsilon \times p_r
      \shortrightarrow Q_o^4 \times A$ determines the outflows from the
    central cell to the neighboring ones, as before. In addition, each
    time an outflow is computed, the neighbour receiving the flow is
    added to the set of active cells.

-   $\sigma_2: A \times Q_h \times (Q_o^4)^4 \shortrightarrow Q_h$
    determines the value of debris thickness inside the cell by
    considering mass exchange in the cell neighborhood. This elementary
    process does not change with respect to the original version
    of SciddicaT.

-   $\sigma_3: A \times Q_h \times p_\epsilon \shortrightarrow A$
    removes a cell from $A$ if its debris thickness is lower than or
    equal to the $p_\epsilon$ threshold.

In order to implement the SciddicaT debris flows model in OpenCAL by
exploiting the active cells optimization, we have to chage the
definition of the CA objet, by also adding the third $\sigma_3$
elementary process. Moreover, the $\sigma_1$ elementary process has to
be changed. A complete implementation of the sactive cells optimized
version of SciddicaT is shown in Listing
\[lst:cal\_Sciddicat-activecells\] for the sake of completeness, even if
only the differences with respect to the original implementation are
commented.

As you can easily see, few modifications to the original source code are
needed to add the active cells optimization to SciddicaT. In particular,
the active cells optimization is enabled by means of the
`CAL_OPT_ACTIVE_CELLS` parameter at line 159, while the third elementary
process added at line 165. As regards the elementary processe
$\sigma_1$, it is the same of the one of the basic SciddicaT version,
with the exception that when an outflow is generated, the cell receiving
the flow is added to the set A of the active cells (line 88). Moreover,
an active cell is eliminated by the set A by means of the $\sigma_3$
elementary process in the case its debris thickness becomes lower than
or equal to the $p_\epsilon$ threshold parameter (lines 107-108).

Regarding the computational preformace, the same simulation shown in
Figure \[fig:sciddicaT\] was executed using the new SciddicaT
implementation adopting the active cells implementation. Still, only a
single core of the Intel Core i7-4702HQ CPU was used, as we did before.
The simulation lasted a total of 22 seconds, versus 172 seconds obtained
for the basic (non-optimized) version, which is about 8 times faster.
This can be condidered a very good result you can easily obtain when
your simulation involves only a limited subset of the computational
domain.

SciddicaT as eXtended CA {#sec:sciddicaT_extended}
------------------------

OpenCAL allows for further optimization of the SciddicaT debris flows
simulation model by means of the so called *unsafe operations*. In fact,
in some cases, it is possible to consider an extended definition of the
computational model, allowing for operations that are not strictly
permitted by the formal definition of Cellular Automata. In particular,
we will allow the transition function to update the state of the
neighbouring cells, while the CA only allows for state change for the
central one. When we will permit such a kind of unsafe operations, we
are in front of an XCA eXtended Cellular Automata. Obviously, in order
to be well defined, the XCA must be equivalent to the original CA model.

An XCA equivalent version of SciddicaT can be obtained by obseving that,
when an outflow is computed from the central cell towards a neighbour,
the flow can be immediatly subtracted from the central cell and added to
the neighbour. This does not change the state of the system at the
current step, which is defined by the *current* computational plane,
since updated values are written to the *next* computational plane. As a
result, the *current* computational plane is not corrupted by the
extended operation, and the *next* plane is used for progressively
accounting mass variation inside the cells. By introducing such feature,
ouflows donâ€™t need to be saved (e.g. into additional substates) anymore,
as they are used to account mass exchange directly during ouflows
computation. As you can figure out, this can give rise to a further
performace improvement for the application. The SciddicaT XCA model is
formally defined as:

$$SciddicaT = < R, A, X, Q , P, \sigma  >$$

where:

-   $R$ is the set of points, with integer coordinates, which defines
    the 2-dimensional cellular space over which the phenomenon evolves.
    The generic cell in $R$ is individuated by means of a couple of
    integer coordinates $(i, j)$, where $0 \leq i < i_{max}$ and
    $0 \leq j < j_{max}$. The firt coordinate, $i$, represents the row,
    while the second, $j$, the column. The cell at coodinates $(0,0)$ is
    located at the top-left corner of the computational grid.

-   $A \subseteq R$ is the set of active cells, i.e. those cells
    actually involved in computation.

-   $X = \{(0,0), (-1, 0), (0, -1), (0, 1), (1, 0)\}$ is the von Neumann
    neighborhood relation (cf. Figure \[fig:2Dneighborhood\]), a
    geometrical pattern which identifies the cells influencing the state
    transition of the central cell. The neighborhood of the generic cell
    of coordinate $(i, j)$ is given by $$N(X, (i, j)) =$$
    $$= \{(i, j)+(0,0), (i, j)+(-1, 0), (i, j)+(0, -1),
    (i, j)+(0, 1), (i, j)+(1, 0)\} =$$
    $$= \{(i, j), (i-1, j), (i, j-1), (i, j+1), (i+1, j)\}$$

    Here, a subscript operator can be used to index cells belonging to
    the neighbourhood. Let $|X|$ be the number of elements in X, and
    $n \in
    \mathbb{N}$, $0 \leq n < |X|$; the notation

    $$N(X, (i, j), n)$$

    represents the $n^{th}$ neighbourhood of the cell $(i,j)$. Thereby,
    $N(X, (i, j), 0) = (i, j)$, i.e. the central cell,
    $N(X, (i, j), 1) =
    (i-1, j)$, i.e. the first neighbour, and so on (cf.
    Figure \[fig:LifeNeighborhood\]).

-   $Q$ is the set of cell states; it is subdivided in the following
    substates:

    -   $Q_z$ is the set of values representing the topographic
        altitude (i.e. elevation);

    -   $Q_h$ is the set of values representing the debris thickness;

    The Cartesian product of the substates defines the overall set of
    state $Q$:

    $$Q = Q_z \times Q_h$$ so that the cell state is specified by:

    $$q = (q_z, q_h)$$

-   $P$ is set of parameters ruling the CA dynamics:

    -   $p_\epsilon$ is the parameter which specifies the thickness of
        the debris that cannot leave the cell due to the effect of
        adherence;

    -   $p_r$ is the relaxation rate parameter, which affects the size
        of outflows (cf. section above).

-   $\sigma : A \times Q^5 \shortrightarrow Q$ is the deterministic cell
    transition function. It is composed by two elementary processes:

    -   $\sigma_1 : A \times (Q_z \times Q_h)^5 \times p_\epsilon \times
          p_r\shortrightarrow (A \times Q_h)^5$ determines the outflows
        from the central cell to the neighboring ones and updates debris
        thickness inside the central cell and its
        neighbours accordingly. It also adds the neighbouring cells
        receining a flow to the set A of the active cells.

    -   $\sigma_2: A \times Q_h \times p_\epsilon \shortrightarrow A$
        removes the cell from the set A of the active cells if the
        debris thickness inside the cell is lower than or equal to the
        $p_\epsilon$ threshold.

Note that, only the topographic altitude and the debris thickness are
now considered as modelâ€™s substates, as the four outflows substates are
no longer needed. Moreover, the number of elementary process now
considered is two, instead of three for the previous versions of
SciddicaT. The OpenCAL implementation of the further optimized SciddicaT
debris flows model is shown in Listing \[lst:cal\_sciddicaT-unsafe\].

As you can see, the definitions of CA and simulation objects doesnâ€™t
change from the previous implementation (lines 131-132), while only two
elementary processes are considered (lines 135-136). In particular, the
firt call to `calAddElementaryProcess2D()` registers the callbak
function implementing the $\sigma_1$ elementary process. It computes
outflows from the (active) central cell to its neighbours (line 83) and
updates the debris tickness in both the central cell and the
neighbouring cell receiving a flow (lines 84-85). Moreover, neighbouring
cells receiving a flow are added to the set A of active cells (line 88)
and therefore will be considered for elaboration by the subsuequent
elementary process ($\sigma_2$) in the current step of computation[^11].
In particular, the `calSetX2Dr()` *unsafe* function is used to update
the derbis thickess of the neighbouring cells receiving a flow, while
the `calAddActiveCellX2D()` function is used to add a neighbouring cells
receiving a flow to the set $A$ of active cells. The $\sigma_2$
elementary process, simply removes inactive cells from $A$ (lines
95-86), as in the previous example.

Substates are added to the CA at lines 139-140. Here, the first
substate, $Q_z$, is added by menas of the
`calAddSingleLayerSubstate2Dr()` function. It is here considered to
allocate memory only for the *current* computing plane. In fact,
topographic altitutde only changes at the simulation initialization
stage (cf. lines 147 and 117), while it remains inalterated during
computation as its value is never updated by the transition function.
This allows for memory space allocation optimization and possibly for
computational performance improvements. Note that, at line 117 we used
the `calSetCurrent2Dr()` function, instead of the usual `calSet2Dr()`.
The `calSetCurrent2Dr()` function allows for updating the *current*
computational plane (the only present in the $Q_z$ substate), while
`calSet2Dr()` would update the *next* computational plane, by producing
an access violation error.

Regarding the computational preformace, the same simulation shown in
Figure \[fig:sciddicaT\] was executed by considering the XCA
implementation of SciddicaT on a single core of the same processor. The
simulation lasted a total of 11 seconds, versus 22 seconds obtained for
the active cells optimized version and 172 seconds for the basic
(non-optimized) version. The XCA implementation resulted 2 times faster
than the active cells optimized version and about 16 times faster with
than the basic one.

SciddicaT with explicit simulation loop
---------------------------------------

Even if results obtained so far can be considered more than satisfying,
it is further possibile to improve computational performance of
SciddicaT by avoiding unnecessary substates updating. In fact, in some
cases, elementary processes donâ€™t affect one or more modelâ€™s substates
and therefore their updating becomes only a waste of time.

As we stated above, when we use the implicit `calRun2D()` simulation
loop, an update of all the defined substates is executed at the end of
each elementary process. However, this behaviour can be modified by
making the OpenCAL simulation loop explicit.

In the specific case of the SciddicaT XCA model, the second elementary
process, $\sigma_2$, just remove cells that became inactive from the set
$A$ of active cells and doesnâ€™t affect the modeâ€™s substates[^12]. As a
consequence, no substates updating is needed after the application of
$\sigma_2$. Being substates udating a time comsuming operation, this can
further speed up your simulation.

A new OpenCAL implementation of SciddicaT is presented in Listing
\[lst:cal\_sciddicaT-explicit\]. It is based on an explicit simulation
loop and also defines a stopping criterion for the simulation
termination. The complete implementation is shown for the sake of
completeness.

As you can see, the `calRunAddGlobalTransitionFunc2D()` function is
called to register a custom transition function callback (line 177). In
the specific case of SciddicaT, the `sciddicaTransitionFunction()`
callback (lines 132-143) is used to make the elementary processes
application and the substates update explicit. Here, the elementary
processes are applied in the same order they are defined by means of the
`calAddElementaryProcess2D()` function (which is the default behaviour
of OpenCAL), even if you are free to re-order the call sequence within
the explicit transition function callback. In particular, the
`sciddicaT_flows()` elementary process is applied to each (active) cell
into the computational domain by means of the
`calApplyElementaryProcess2D()` function. Then, the set $A$ of the
active cells and the $Q_h$ substate are updated by means of the
`calUpdateActiveCells2D()` and `calUpdateSubstate2Dr()`,
respectively[^13]. Eventually, the `sciddicaT_remove_inactive_cells()`
elementary process is applied, which only removes cells that became
incative during the current computational step, and the set $A$ is
accordingly updated.

As regard the computational performance, this further optimized version
lasted 12 seconds to complete the 4000 steps required by the simulation
on a single core of the same Intel Core i7 processor used before. The
obtained sped up is here quite small (less than the 10%) with respect to
the previous implementation of SciddicaT. However, SciddicaT is a very
simplyfied model and higer speed up can certainly be obtained for more
complex CA made up by more elementary processes, theese latter involving
only a small set of modelâ€™s substates. Table \[tab:speedup\] resumes
computational performace of all the above illustraed SciddicaT
implementations.

  CA model                         Elapsed time \[s\]   Speedup
  ------------------------------- -------------------- ---------
  SciddicaT                               240              1
  SciddicaT with active cells              23            10.43
  SciddicaT XCA (eXtended CA)              13            18.46
  SciddicaT XCA explicit update            12             20

  : Computational performace of the four different implementations of
  the SciddicaT debris flows model.<span
  data-label="tab:speedup"></span>

A three-dimensional example {#sec:mod2}
---------------------------

In order to introduce you to development with of three-dimensional CA
with OpenCAL, we start this section by implementing a simple 3D model,
namely the *mod2* 3D CA. Cells can be in one of two differnt states, 0
or 1, as in Game of Life. The cellular space is a parallelepiped made by
cubic cells, while the cellâ€™s neighbourhood is the 3D Moore one,
consisting of the central cell and its adjecent cells. The transition
function simply evaluates the quantity $s$ as the number of neighbouring
cells which are in the state 1 and sets the new state for the central
cell as $s\%2$ (i.e. the rest of $s$ divided by 2). This simple example
of 3D CA is formally defined as:

$$mod2 = < R, X, Q, \sigma >$$

where:

-   $R$ is the set of points, with integer coordinates, which defines
    the 3-dimensional cellular space. The generic cell in $R$ is
    individuated by means of a triple of integer coordinates $(i, j,
      k)$, where $0 \leq i < i_{max}$, $0 \leq j < j_{max}$, and
    $0 \leq k
      < k_{max}$. The firt coordinate, $i$, represents the row, the
    second, $j$, the column, while the third coordinate represents
    the slice. The cell at coodinates $(0,0,0)$ is located at the
    top-left-far corner of the computational grid.

-   $X = \{(0,0,0), \dots, (-1,1,0), (0,0,-1), \dots, (-1,1,-1),
      (0,0,1), \dots, (-1,1,1)\}$ is the Moore neighborhood relation, a
    geometrical pattern which identifies the cells influencing the state
    transition of the central cell. The neighborhood of the generic cell
    of coordinate $(i, j)$ is given by $$N(X, (i, j, k)) =$$
    $$= \{(i, j, k)+(0,0,0), \dots, (i, j, k)+(-1,1,-1)\} =$$
    $$= \{(i, j, k), \dots, (i-1,j+1,k-1)\}$$ Here, a subscript operator
    can be used to index cells belonging to the neighbourhood. Let $|X|$
    be the number of elements in X, and $n \in
      \mathbb{N}$, $0 \leq n < |X|$; the notation

    $$N(X, (i, j, k), n)$$

    represents the $n^{th}$ neighbourhood of the cell $(i,j,k)$.
    Thereby, $N(X, (i, j, k), 0) = (i, j, k)$, i.e. the central cell,
    $N(X, (i, j, k), 1)
      = (i-1, j, k)$, i.e. the first neighbour, and so on.

-   $Q = \{0, 1\}$ is the set of cell states.

-   $\sigma : Q^{27} \shortrightarrow Q$ is the deterministic cell
    transition function. It is composed by one elementary process, which
    implements the previously descripted transition rules.

As you can imagine, the OpenCAL implementation of the *mod2* 3D CA is
very simple, as the Conwayâ€™s game of Life is. The complete source code
is shown in Listing \[lst:cal\_mod2CA3D\].

As you can see, even if Listing \[lst:cal\_life\] is very short, it
completely defines the *mod2* 3D CA and perform a simulation (actually,
only one step in this example). Lines 3-5 include some header files for
the 3D version of OpenCAL, while lines 12-14 declare CA, substate and
simulation objects. They are therefore defined later in the main
function. In particular, line 30 defines the CA as a parallelepiped
having `ROWS` rows, `COLS` columns and `SLICES` slices (cf. lines 7-9).
Moreover, the 3D Moore neighbourhood is here set as well as cyclic
conditions at boundaries. Eventually, no optimizations are considered.
Line 31 defines the simulation object by setting just one step of
computation and implicit substateâ€™s update. Finally, the only substate,
$Q$, is defined at line 34. Note that, since it was defined by means of
the `calInitSubstate3Db()` function, each element $q \in Q$ results to
be of the CALbyte type. Line 37 registers the only CAâ€™s elementary
process, namely the `mod2_transition_function()` function, which is then
implemnented at lines 17-25. Line 43 initializes the cellâ€™s substated
$Q$ at coordinates (2, 3, 1) to the state 1. The obtained initial
configuration is then saved to disk at line 46, and the simulation ran
at line 49. The final configuration is therefore saved to disk at line
52 and, eventually, memory previously and implicitly allocated is
released at lines 55-56. Note that, diffrently to the previous examples,
almost all the OpenCAL functions come in the 3D flower. For instace,
this is the case of the `alGetX3Db()` and `calSet3Db()` functions at
lines 22 and 24, respectively, which take `k` as third cellâ€™s
coordinate, identifying the cellular spaceâ€™s slice.

Figures \[fig:mod2\_0000\] and \[fig:mod2\_LAST\] show the initial and
final configuration of *mod2* 3D CA as implemented in Listing
\[lst:cal\_mod2CA3D\], respectively. A graphical representation after 77
computational step is shown in Figure \[fig:cal\_mod2CA3D\].

![Initial configuration of mod2 3D CA, as implemented in Listing
\[lst:cal\_mod2CA3D\].<span
data-label="fig:mod2_0000"></span>](./images/OpenCAL/mod2_0000){width="3.5cm"}

![Final configuration of mod2 3D CA (actually, just one step of
computation), as implemented in Listing \[lst:cal\_mod2CA3D\].<span
data-label="fig:mod2_LAST"></span>](./images/OpenCAL/mod2_LAST){width="3.5cm"}

![Graphical representation of the mod2 3D CA after 77 computational
steps, as implemented in Listing \[lst:cal\_mod2CA3D\]. CA dimensions
were set to (rows, cols, slices) = (65, 65, 65), while the initial seed
located at coordinates (12, 12, 12). Cells in black are in the state 0,
cell in white are in the state 1.<span
data-label="fig:cal_mod2CA3D"></span>](./images/OpenCAL/mod23DCA-glut){width="12cm"}

Combining OpenCAL and OpenCAL-GL
--------------------------------

In this section, we will show how you can combine the OpenCAL and
OpenCAL-GL libraries to have an immediate graphic output of your
simulation. At this purpose, here we re-propose two of the examples
presented above, namely the SciddicaT debris flow model and the *mod2*
CA, by adding them an OpenGL-based visualizer in a straightforward
manner. The visualization system provided by OpenCAL-GL is however
rather simplyfied and therefore, if you need a more sophisticated
graphic system you have to develop an alternative by yourself.

### Implementing SciddicaT in OpenCAL and OpenCAL-GL

A new implementation of SciddicaT is presented in Listing
\[lst:calgl\_sciddicaT\], which integrates a simple multi-view 2D and 3D
visualization system based on OpenCAL-GL. The complete implementation is
shown for the sake of completeness in Listing \[lst:calgl\_sciddicaT\].
A screenshot is shown in Figure \[fig:calgl\_sciddicaT1\].

![Screenshot of the SciddicaT debris flow model with a multi-view 2D and
3D visualization system based on OpenCAL-GL.<span
data-label="fig:calgl_sciddicaT1"></span>](./images/OpenCAL/calgl_sciddicaT1){width="12cm"}

As you can see,

### Implementing the *mod2* CA in OpenCAL and OpenCAL-GL

OpenCAL Global Functions
------------------------

OpenCAL comes with some functions you can use to perform global
operation over the cellular space. They essentially are reduction
function. Note that such functions should not used within elementary
processes, but only in the initialization, steering and stop condition
functions. The proper use of global functions is your own
responsibility.

In ordert to use global functions in your application, simply include
the XXXXXX. Table YYYYYY lists the OpenCALÃ¬â€™s global functions.

OpenCAL OpenMP version {#ch:opencal-omp}
======================

Nowadays, parallel computing is the most effective solution to overcome
temporal limits of sequential computation. With the name OpenCAL-OMP, we
identify the OpenMP implementation of the software library, that can run
on all cores for your CPU. If you are lucky and have a shared memory
multiptocessor system, OpenCAL-OMP can also exploit all the cores of all
your CPUs.

Similarly to the serial version, OpenCAL-OMP allows for some *unsafe
operations*, which can significantly speed up your application. However,
when you use OpenCAL-OMP in *unsafe mode* you must give the utmost
attention to avoid *race condition* issues. For instance, when many
threads perform concurrent operations on the same memory locations and
such operations are made by more than one atomic machine instruction, it
can happen that they can interleave, giving rise to wrong (i.e., non
consistent) results. Furthermore, even in the case of atomic operations,
the logic order of execution could not be respected. Thus, for instance,
a read-write logic sequence of atomic operations can actually become a
write-read (wrong) sequence due to the fact that the thread performing
the write operation is executed first.

In the following sections we will introduce OpenCAL-OMP by examples,
highlighting source code the differences with respect to the serial
implementations shown in Chapter \[ch:opencal\]. In the first part of
the Chapter, we will deal with the OpenCALâ€™s *safe mode*, while in the
last one, we will discuss unsafe operations.

Conwayâ€™s Game of Life in OpenCAL-OMP
------------------------------------

In Section \[sec:cal\_life\], we described Conwayâ€™s Game of Life and
shown a possible implementation using the `OpenCAL` serial library.
Here, we present a `OpenCAL-OMP` implementation of the same cellular
automaton (Listing \[lst:calomp\_life\]), by discussing the differences
with respect its serial implementation (Listing \[lst:cal\_life\]).

As you can see, the OpenMP-based implementation of Life, which uses only
safe operations, is almost identical to the serial one thanks to the
seamless parallelization adopted by the library. The only differences
can be found at lines 3-5 where, instead of including the OpenCAL header
files, you can find the OpenCAL-OMP headers. All the remaining source
code is unchanged. Note that also the OpenCAL-OMP statementsâ€™ prefix
does not change with respect to the OpenCALâ€™s one (i.e. `cal` for the
functions, `CAL` for the data types, and `CAL_` for the constants). In
practice, if you only use OpenCAL-OMP in safe mode, besides including
the proper OpenCAL-OMP header files instead of the OpenCAL ones, minimal
changes are required to the serial code.

SciddicaT {#sciddicat}
---------

As for the case of Conwayâ€™s Game of Life, even the OpenCAL-OMP
implementation of the SciddicaT cellular automaton, shown in Lsting
\[lst:calomp\_sciddicaT\], does not significantly differ from the serial
implementation that you can find in the Section \[sec:sciddicaT\],
Listing \[lst:cal\_sciddicaT\]. As before, the only differences regard
the included headers (lines 3-5). Even in this case, as for the Life
cellular automaton, due to the fact we used only OpenCAL-OMP safe
operations, mimimal code change is required, besides including the
proper OpenCAL-OMP header files instead of the OpenCAL ones.

SciddicaT with active cells optimization {#sciddicat-with-active-cells-optimization}
----------------------------------------

Here we present an OpenCAL-OMP implemenation of SciddicaT, which takes
advantage of the built-in OpenCAL active cells optimization feature. You
can find the complete source code in Listing
\[lst:calomp\_Sciddicat-activecells\], while the corresponding serial
implementation can be found in Section \[sec:sciddicaT\_active\],
Listing \[lst:cal\_Sciddicat-activecells\].

With respect to the Sciddica implementation shown in Listing
\[lst:calomp\_sciddicaT\], which is exclusively based on safe
OpenCAL-OMP operations, the active cells management as implemented here
requires an unsafe operations. Such unsafe operations are performed by
means of the `calAddActiveCellX2D()` function (line 87), which adds a
cell belonging to the neighbourhood to the set $A$ of active cells. As
evident, such an operation is considered unsafe because it can give rise
to race condition. In fact, if more threads try to add the same cell to
the set $A$ at the same time, being this a non-atomic operation,
threadsâ€™ operations can interleave and the outcome be wrong. In order to
avoid this possible error, OpenCAL-OMP is able to *lock* the memory
locations involved in the operations so that each thread can entirely
perform its own task without the risk that other threads interfere. In
order to do this, it is sufficient to place OpenCAL-OMP in *unsafe*
state by calling the `calSetUnsafe2D()`, as done at line 163. No other
modifications to the serial source code are required.

SciddicaT as eXtended CA {#sciddicat-as-extended-ca}
------------------------

Here we present an OpenCAL-OMP implementation of SciddicaT, which takes
advantage of the built-in unsafe operations. They belong to the eXtended
CA definition and allow for further computational optimizations. You can
find the complete source code of SciddicaT implemented as an eXtended CA
in Listing \[lst:calomp\_SciddicaT-unsafe\], while the corresponding
serial implementation can be found in Section
\[sec:sciddicaT\_extended\], Listing \[lst:cal\_sciddicaT-unsafe\].

First of all - from a XCA modeling point of view - note that only the
topographic altitude and the debris thickness are now considered as
modelâ€™s substates (lines 25-28, 147-148), as the four outflows substates
are no longer needed. Moreover, the number of elementary process now
considered is two (lines 143-144), instead of three for the previous
versions of SciddicaT.

The call to the `calSetUnsafe2D()` function (line 139) places
OpenCAL-OMP in unsafe mode, allowing to lock memory locations (i.e.
cells) that can be simultaneously accessed by more threads. In order
properly exploit the OpenCAL-OMPâ€™s built in lock feature, you have to
use specific functions, which are provided by the
`OpenCAL-OMP/cal2DUnsafe.h` header file (line 6). In the specific case,
besides the already discussed `calAddActiveCellX2D()` function, the
`calAddNext2Dr()` and `calAddNextX2Dr()` functions are employed (lines
88-89), in place of the combination of get-set operations, as done in
the corresponding serial implementation (Listing
\[lst:cal\_sciddicaT-unsafe\], lines 84-85). In fact, consider the
source code snippet in Listing \[lst:get-set\] (checked out by Listing
\[lst:cal\_sciddicaT-unsafe\]). As you can see, for each not-eliminated
cell, the algorithm computes a flow, $f$ (line 5) and then subtracts it
from the central cell (line 6), adding it to the corresponding neighbour
(line 7), in order to accomplish mass balance. In both cases (flow
subtraction and adding), a flavor of `calGet` function is called to read
the current value of the $Q_h$ substate from the next working plane.
Subsequently, a flavor of the `calSet` function is used to update the
previously read value. When a single thread is used to perform such
operations, no race conditions can obviously occur. At the contrary,
even in the case of two concurrent threads, different undesirable
situations can take place, which give rise to a race condition and
therefore to a wrong result. For instance, letâ€™s suppose both threads
read the value first, and then write their updated values; in this case,
the resulting value will correspond to the one written by the thread
that writes the value for last, and the contribution of the other thread
will be lost.

      // <snip>
      for (n=1; n<sciddicaT->sizeof_X; n++)
      if (!eliminated_cells[n])
      {
        f = (average-u[n])*P.r;
        calSet2Dr (sciddicaT,Q.h,i,j,  calGetNext2Dr (sciddicaT,Q.h,i,j)  -f);
        calSetX2Dr(sciddicaT,Q.h,i,j,n,calGetNextX2Dr(sciddicaT,Q.h,i,j,n)+f);
        // <snip>
      }
      // <snip>

In order to avoid such kind of problems when dealing with more threads,
the above mentioned `calAddNext2Dr()` and `calAddNextX2Dr()` functions
lock the cell under consideration and then perform the get-set
operations without the risk other threads can interfere. In this way, no
race conditions can be triggered. Obviously, there is a side-effect in
terms of computational performance. In fact, as expected, locks can slow
down threads execution and therefore the entire simulation.

SciddicaT with explicit simulation loop
---------------------------------------

As for the serial version, also for the OpenMP based release of OpenCAL
it is further possible to improve computational performance of SciddicaT
by avoiding unnecessary substates updating.

As already reported, the `calRun2D()` function used so far to run the
simulation loop updates all the defined substates at the end of each
elementary process. However, in the specific case of the SciddicaT XCA
model, no substates updating should be executed after the application of
the second elementary process, as this just removes inactive cells from
the set $A$.

A new OpenCAL implementation of SciddicaT is presented in Listing
\[lst:calomp\_sciddicaT-explicit\]. It is based on an explicit global
transition function, defined by means of
`calRunAddGlobalTransitionFunc2D()`. It registers a callback function
within which you can both reorder the sequence of elementary processes
to be applied in the generic computational step, and also select which
substates have to be updated after the execution of the different
elementary processes. The SciddicaT implementation here presented in
Listing \[lst:calomp\_sciddicaT-explicit\] also makes explicit the
simulation loop and defines a stopping criterion for the simulation
termination.

SciddicaT computational performance
-----------------------------------

Table \[tab:speedup\] resumes computational performance of all the above
illustrated SciddicaT implementations as implemented in OpenCAL-OMP. The
considered case of study is the simulation of the Tessina landslide
shown in Figure \[fig:sciddicaT\], which required a total of 4000
computational steps. The adopted CPU is a Intel Core i7-4702HQ @ 2.20GHz
4 cores (8 threads) processor, already considered for the performance
evaluation of the corresponding serial SciddicaT implementations
described in Chapter \[ch:opencal\]. Results are provided both in terms
of elapsed time and speed up with respect to the corresponding serial
version. Elapsed times of the serial simulations are also reported.

  T version        Serial \[s\]      1thr          2thr          4thr          6thr          8thr
  --------------- -------------- ------------- ------------- ------------- ------------- ------------
  naive                240s       0.82 (293s)   1.22 (196s)   1.53 (157s)   1.64 (146s)   1.6 (150s)
  active cells         23s        0.77 (30s)    1.36 (17s)    1.77 (13s)    2.09 (11s)    2.3 (10s)
  eXtended CA          13s        0.77 (17s)     1.86 (7s)     2.6 (5s)      2.17 (6s)     2.6 (5s)
  explicit loop        12s        0.75 (16s)     1.2 (10s)     2.4 (5s)      2.4 (5s)      3.0 (4s)

  : Speedup of the four different implementations of the SciddicaS3hex
  debris flows model accelerated by OpenMP.<span
  data-label="tab:speedup"></span>

As you can see, results are quite good. In particular, the better
results in terms of speed up were obtained for the fully optimized
SciddicaT implementation (with the explicit substate updating feature),
which runs 3 time faster than the corresponding serial version when
executed over 8 threads. Nevertheless, consider that the SciddicaT
simulation model here adopted is quite simple and better performance in
terms of speed up can certainly be obtained for CA models with more
complex transition functions and extended computational domains.

Eventually, please note how progressive optimizations can considerably
reduce the overall execution time. In fact, if for the naive (i.e., non
optimized at all) serial implementation the elapsed time was 240s, for
the fully optimized parallel version the simulation lasted only 3
seconds, corresponding to a speed up value of 80, i.e. the fully
optimized parallel version runs 80 times faster than the serial naive
implementation.

A three-dimensional example {#a-three-dimensional-example}
---------------------------

In Section \[sec:mod2\], we described the *mod2* 3D CA and shown a
possible implementation using the `OpenCAL` serial library. Here, we
briefly present a `OpenCAL-OMP` implementation of the same cellular
automaton (Listing \[lst:calomp\_life\]), by discussing the differences
with respect the corresponding serial implementation (Listing
\[lst:cal\_life\]).

As you can see, the OpenMP-based implementation, which uses only safe
operations, is almost identical to the serial one. As for the case of
the Game of Life CA, the only differences can be found at lines 3-5
where, instead of including the OpenCAL header files, we included the
OpenCAL-OMP headers. All the remaining source code is unchanged.

OpenCAL OpenCL version {#ch:opencal-cl}
======================

This chapter introduces OpenCAL-CL, a porting of OpenCAL in OpenCL.
OpenCL is a parallel framework originally proposed by Apple and then
released as an Open Standard under the Khronos Group management. Besides
computational efficiency, one of the main advantages of OpenCL is
portability. In fact, you can run your program wherever you want across
heterogeneous processors like Central Processing Units (CPUs), Graphics
Processing Units (GPUs), Digital Signal Processors (DSPs), and
Field-Programmable Gate Arrays (FPGAs).

OpenCAL-CL inherits many OpenCALâ€™s features, by also adding parallel
computation capability thanks to the adoption of OpenCL. The application
is now subdivided in two parts: the *host program*, running on the CPU,
and the *device program*, running on a compliant computational device
(e.g. an Nvidia or AMD GPU). The CA object is still defined host-side,
as in OpenCAL, while elementary processes (and possibly other functions)
are defined device-side. Belonging to the device program, CA elementary
processes must be defined as OpenCLâ€™s *kernels* and therefore the
programmer has to be able to write some minimal OpenCL code to implement
them. Fortunately, OpenCAL-CL hides lots of parallel aspects to the user
(e.g. the simulation loop is internally managed by the library) and also
simplifies data exchange between host and device. The userâ€™s OpenCL
parallel programming background can be therefore limited or even null.
In the latter case, the user can learn some basic elements of OpenCL
kernel programming thanks to this guide.

This chapter is divided into two parts: the first part is a very brief
overview of OpenCL, while the second one introduces OpenCAL-CL by
examples.

OpenCL framework {#sec:openclstructure}
----------------

OpenCL enables parallel programming that assigns computational tasks to
multiple processing elements to be performed at the same time. These
tasks are called *kernels*. A kernel is a special function that can be
executed to different OpenCL-compliant devices. In the CA modeling
context, each elementary process of the CA transition function is
devised in the OpenCAL library as a kernel. The kernels are sent to the
device(s) by the host application. The host application defines a
structure called *context*, needed to manage data exchange and
computation on the compliant devices.

In particular, host application links kernels into one or more programs.
In the host application, the user can select the kernelâ€™s functions to
insert inside a container called *program*. The program connects the
kernel with argument data and dispatches it to a structure called
*command queue*. The command queue is a structure that allows the host
to decide what the devices have to do and, when a kernel is enqueued,
the device will execute the relative function.

![General structure of a OpenCL program<span
data-label="fig:GeneralStructure"></span>](./images/OpenCAL-CL/kernelDistribution){width="12cm"}

As we can see from the picture above, the context contains all the
devices, all the command queues and all the kernels. More in detail, for
every device a command queue is associated and every command queue has
inside all the kernel functions that the device has to execute.

The structure of OpenCAL-CL
---------------------------

As in OpenCL applications, the OpenCAL-CL library has a set of
structures and functions to develop host program and to define kernels.
The definition of the CA is specified in the host program. The user can
define two types of models, 2D or 3D, as shown in \[ch:opencal\]. The
host program manages the kernels and dispatches the data of the mode
(e.g., CA substates, the type of neighbourhood, size of the cellular
space, etc) to the computation units. The host program manages the
execution loop and which computation unit has to execute the transition
functions.\
The host program is typically divided in the following sections:

-   definition of the model (Chapter \[ch:opencal\])

-   management of the OpenCL devices

-   kernels allocation

-   data dispatch from the model to devices

-   execution loop start

Host programming
----------------

### Definition of the model

XXX

### Manage of the devices

After the model creation, the user must choose the device for the kernel
computation. Inside the library, a structure called CALOpenCL allows the
user to manage all available platforms and devices. This structure
simplifies the access to the devices compared with the native API of
OpenCL. The library supplies other functions to know which platforms and
devices are available on the system and to have information about
these.\
Below you can see a simple program that explains how the CALOpenCL
structure can be used.

    #include <calCL2D .h>

     int main (){

     CALOpenCL * calOpenCL = calclCreateCALOpenCL (); // get all available
     platforms calclInitializePlatforms ( calOpenCL ); // get all
     available devices calclInitializeDevices ( calOpenCL );

     // get the first device on the first platform CALCLdevice device =
     calclGetDevice ( calOpenCL , 0, 0);

     // create a context CALCLcontext context = calclcreateContext (&
     device , 1);

     return 0; }

Inside the library, the platforms and the devices are stored in a matrix
where rows represent the platforms and columns represent the devices.
Thus, to choose which one we can use for the computation, it is
necessary to specify the index of platform and the index of the device.
For example, at lines 12, we chose the platform number 0 and the device
number 0. If we have a system with 3 NVIDIA GPUs and 3 AMD GPUs, the
library will have a $2 \times 3$ size matrix, where 2 are the vendors
(i.e., the platforms NVIDIA and AMD) and 3 are the GPUs for each
platforms. If we want to run the program using the third AMD GPU, we can
specify 1 and 2 as indices. If we donâ€™t know how the system identifies
the platforms and devices, the library supplies us a function called
`calclGetPlatformsAndDeviceFromStandardInput` that allows us to know the
available platforms and devices. First it prints the information on
standard output and then we can insert the indexes directly from
standard input.\
After the device is chosen, the user must specify the path where the
kernels and relative headers are. Through the function
`calclLoadProgramLib(2D/3D)` the library reads automatically the kernels
and compiles them.

    CALCLprogram calclLoadProgramLib(2D|3D) ( CALCLcontext context ,
    CALCLdevice device , char * path_user_kernel , char *
    path_user_include )

### Allocation of kernels

The library doesnâ€™t know which kernels are related to the CA elementary
processes, nor their execution order on the available devices. Thus, to
create and allocate a kernel itâ€™s necessary to call the function
`calclGetKernelFromProgram` that retrieves an OpenCL kernel given a
compiled OpenCL program.

    cl_kernel elementaryProcess = calclGetKernelFromProgram(&program,
    KERNEL_NAME);

### Send data from the model to devices

To transfer the data from host side to kernel side, the user must define
the structure called `CALCLToolkit(2D/3D)` containing all the buffers
(data) of the model. By default, the library sends to all the kernels
the data associated to the model. The following list shows the data
which is sent:

-   the dimension of cellular space

-   the number of substate for every type (i.e., byte, int, real)

-   the substates allocated from the user

-   the list of active cells

-   the list of active cells flags

-   type, dimension and ID of the neighbourhood

-   the border condition

First, the user must create an instance of the structure
`CALCLToolkit(2D/3D)` by calling the function `calclCreateToolkit` as
shown in the following code snippet.

    CALCLToolkit2D * calclCreateToolkit (2D|3D)(struct CALModel (2D|3D)
    *model ,CALCLcontext context ,CALCLprogram program ,CALCLdevice device
    ,CALCLOptimization opt)

The enumerative `CALCLOptimization` allows the user to choose if she/he
wants to use the library without optimization `(CALCL_NO_OPT)` or with
active cells optimization `(CALCL_OPT_ACTIVE_CELLS)`. The structure
`CALCLToolkit(2D/3D)` doesnâ€™t contain only the buffers to transfer data
but also the kernels belonging to the execution loop.\
To add a new kernel to the execution loop, the user has to call the
function `calclAddElementaryProcessKernel(2D/3D)` that adds the chosen
kernel to the list of CA elementary processes; moreover, it sends to the
device all the necessary data to execute the kernel.

    void calclAddElementaryProcessKernel2D(CALCLToolkit2D * toolkit2d,
    struct CALModel2D *model, CALCLkernel * elemProcKernel);

### Start execution loop

To start the execution loop, the user has to call the function
`calclRun(2D/3D)`. This function executes all the elementary processes
previously declared on the specified device.

    void calclRun2D(CALCLToolkit2D* toolkit2d, struct CALModel2D * model,
    unsigned int initialStep, unsigned maxStep);

Kernel programming
------------------

In order to program kernels in OpenCAL, the user needs to include some
header files. Specifically, cal2D.h or cal3D.h permit to use some simple
functions to interact with the data structures belonging to the model.
To create a kernel function in OpenCL, user must place the keyword
`__kernel` before the returning the type of the function. In OpenCAL-CL
every time a kernel function, the keyword `MODEL_DEFINITION2D` must be
specified as first parameter and the function `initThreads2D()` called
as first instruction.\
The code below shows how to declare a new kernel.

    __kernel void kernel(MODEL_DEFINITION2D){ initThreads2D(); ...  ...
        ...  }

When the user implements an elementary process - by defining its kernel
function - she/he can rely on a set of OpenCAL functions that allow to
get the substates values of both the central and the neighbouring cells,
and to update the substates values of the central cell. Every time the
user wants to use this function, the keyword `MODEL2D` must be passed as
first parameter. For instance, if we want to retrieve the value of a
specific cell we need to use the function `calGet2Dr`.

    	double a = calGet2Dr(MODEL2D, 0, i, j);

The function returns the value of the cell (i, j) of the substate 0.\
Since inside OpenCAL-CL one can use all OpenCL features, all memory
levels such as global memory, local memory, private memory (XXXcitazione
libroXXX) can be exploited. In order to use these memory levels,
variables must be declared using this specific syntax respectively
`__global`, `__local`, `__private`.

Conwayâ€™s Game of Life with OpenCAL-CL
-------------------------------------

As already reported in \[sec:cal\_life\], to introduce how to develop a
Cellular Automata model with OpenCAL-CL we can start by implementing
Conwayâ€™s Game of Life and specifically its host application part. In
order to use OpenCAL-CL, some header files are included (lines 3-8) and,
in particular, the OpenCAL library and the OpenCAL-CL library. The
OpenCAL library inclusion inside the host application is necessary to
define the CA object (line 46) and the related substates (line 49). The
cal2DIO.h header file (line 4) provides some basic input/output
functions for reading/writing substates from/to file. To run the
application with OpenCAL-CL, all the necessary objects have to be
declared (line 27-31): specifically, the `CALOpenCL` structure (line
27), the `CALCLcontext`, the `CALCLdevice`, the `CALCLprogram` and the
`CALCLToolkit2D`. To create and initialize these variables we need to
call the function `calclCreateCALOpenCL` that creates the CALOpenCL
structure, the functions `calclInitializePlatforms` and
`calclInitializeDevices` that initialize all the platforms and devices
on the available machine and the `calclGetDevice()` function, which will
return the device where elementary process are computed by choosing the
`platformNum` and `deviceNum` integers(line 24-25). Moreover, two
important functions are here considered: `calclcreateContext` and
`calclLoadProgramLib2D`. The first returns the context
\[sec:openclstructure\], while the second builds all kernels inside the
path specified by `kernelSrc`(line 15) including the files specified by
`kernelInc`(line 16), and returns a program containing all the compiled
kernels.

The definition and declaration of the model (line 46) has the same code
that we discussed in \[sec:cal\_life\], and includes all the information
to create the model, to create and initialize substates (line 49-52) and
to set a initial configuration (line 55-59).

Although the OpenCAL-CL library uses the same functions of the OpenCAL
library to create the model and the substates, the execution of the
elementary processes is quite different. As known, our elementary
processes are implemented on GPU side through kernels, so we need to
manage the transfer of memory between host and device sides and to
decide which and when run the kernels. In a classical OpenCL
application, itâ€™s not trivial to handle all these issues. For this
reason, in OpenCAL-CL we decided to introduce an intermediate object
(`CALCLToolkit`) that hides to the user the memory management and
handles the compiled chosen kernels. The user must only initialize the
`CALCLToolkit` structure(line 62) and choose which kernel he/she wants
to execute by the function `calclGetKernelFromProgram` specifying the
program and kernel names. Once kernels are chosen to be executed, the
user must only call the function `calclAddElementaryProcessKernel2D`
(line 71) that adds the specific kernel elementary process inside the
`CALCLToolkit` structure. Finally, to run the simulation the user must
call the function `calclRun2D` specifying the initial and final step.

Below is reported the device side code of Conwayâ€™s Game of Life. In this
application, we have only one elementary process, defined as a kernel
called `life_transition_function`.\
The OpenCAL-CL library will launch exactly a number of threads equal to
the entire cellular space, structured like a matrix. In this way, every
cell can perform in parallel its own computation. To access to the
indexes of the cell the user must call the function `getRow` and
`getCol` line(14-15). Furthermore, the user can use the function
`get_columns` and `get_rows` (line 17-18) to retrieve the dimensions of
the cellular space. In the specific case of the Game of Life, we used
the `calGet2Di` function to get the central cellâ€™s value of the sub-
state Q (remember that the central cell is identified by the coordinates
(i, j)), the `calGetX2Di` function to retrieve the value of the n-th
neighbourâ€™s substate Q, and the `calSet2Di` function to update the value
of the substate Q for the central cell.

OpenCAL OpenGL version
======================

[^1]: Indeed, even 1D CA can be defined oas a degenerate case of 2D, or
    even 3D, CA.

[^2]: The clang C compiler can also be used, taking in mind that it
    still does not fully support Open-MP natively.

[^3]: For a list of OpenMP compliant compilers see the following link:
    <http://openmp.org/wp/openmp-compilers/>.

[^4]: OpenCAL-CL was tested on the NVIDIA OpenCL implementation. You can
    find the NVIDIAâ€™s OpenCL implementation, shipped with the CUDA
    platform, at the following url:
    <http://docs.nvidia.com/cuda/#installation-guides>

[^5]: For example `freeglut-devel` or `freeglut3-dev` packages on
    `yum/dnf`- and `apt`-based systems, respectively.

[^6]: XCA are also known as Complex Cellular Automata (CCA), Macroscopic
    Cellular Automata (MCA), and Multicomponent Cellular Automata (MCA)

[^7]: Note that, in the case of the Game of Life CA, the central cell
    does not belong to its own neighborhood.

[^8]: This characteristic is colled *implicit parallelism* and is
    obtained in OpenCAL by considering two different working planes for
    each registered substate, namely *current* and *next* working
    planes. However, behind the scene, cells are updated sequentially,
    being OpenCAL a serial software. The *current* working plane is used
    to read current values for the cells, while the *next* working plane
    is used to write updated values. The *implicit parallelism* is also
    used in the parallel versions of OpenCAL, with the difference that
    more than one cell can be processed and updated concurrently by
    exploiting mre than one processing unit.

[^9]: On the serial version of OpenCAL, implicit parallelism is obtained
    by exploiting the two different computing planes built into
    OpenCALâ€™s substates. The first one, that we will call *current*, is
    used to read substatesâ€™s values for the central cell and its
    neighbours, while the second, that we will call *next*, is used to
    update the new state for the central cell. When all the cells have
    been processed and the new state values updated, computing planes
    are switched, i.e. the *next* plane is assumed as *current* and the
    *current* as *next*, and the process is reiterated. In this manner,
    the *current* computing plane is not *corrupted* during a
    computational step, being new values written to the *next* plane.
    Note that, even in the case more processing units are used to
    compute the next CA state and more cells are updated simltaneously,
    which is the case of OpenCAL-OMP and OpenCAL-CL, the two computing
    planes are manteined.

[^10]: Remember that, by default, substates are updated after the
    application of each alementary process.

[^11]: This is due to the fact that a substatesâ€™ update is performed
    after the first elementary process has been applied to all the
    (active) cells of the cellular space. This behaviour is set by menas
    of the `CAL_UPDATE_IMPLICIT` parameter used in the definition of the
    simulation object at line 132 of Listing
    \[lst:cal\_sciddicaT-unsafe\].

[^12]: Actually, only $Q.h$ can be update by the transition function,
    since $Q.z$ is a single-lyered substate.

[^13]: Note that active cells are updated first otherwise the subsequent
    substate update could neglect some cells that have become active
    during the current step. For instance, inactive cells can receive a
    flow and become active at he current step of computation. If the set
    of active cells is not updated before any other substates, those new
    cells will still be considered inactive during the current step and
    their value will not be updated, by losing debris flow mass.
