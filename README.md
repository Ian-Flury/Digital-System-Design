# Digital-System-Design
- This repo holds the code from my CPEN 430 Digital Design Class.
- There are multiple fully completed lab projects, and a few smaller homework assignments here.
- The lab for this class was an introduction to the Altera Design flow and tools (Quartus and ModelSim), and taught me how to do the project setup, design work, simulation, and synthesis for a range of designs.

## Labs:

#### Tut1Dir
- Tutorial 1 is a simple lab that served as an introduction on how to setup a project in Quartus.

#### Lab 2 Comparator
- Lab 2 is a simple comparator design that takes two 2-bit unsigned numbers and compares them, check for equality. The circuit then outputs the status of the comparison on a seven segment display.
- Here I learned how to write test benches and simulate my design with ModelSim and write automation scripts which allow the process to be driven from a CLI.

#### Lab 3 Switch Debouncer:
- Lab 3 was an introduction to FSMs in VHDL and was a great forcing function in my understanding of processes.
- There are definitely more elegant and simpler ways to implement this functionality, but with my limited understanding at the time this is what I came up with.

#### Lab 4 Tail Light FSM
- Lab 4 is the implementation of the taillights of a 1965 Ford Thunderbird. Another FSM, but this time I implemented the design with a simple hierarchy, and reused a counter component that I created in an earlier assignment.

#### Lab 5 LCD Controller
- Lab 5 is a simple hardware FSM LCD controller (nightmare project).
- This project had some more complex hierarchy, and required some interpretation of the lackluster LCD's data sheet.
- The commands and their timings took some trial and error to figure out.
- I also wrote a "professional" test bench which starts to enter the realm of an automated test.
- This in itself if quite a process and it taught me that often times __it takes just as long to write the test bench as it did to implement the design__.

- At this point in the class I was ready to try something a bit more challenging:

The final class project was to "implement an embedded system on the given Altera FPGA with a NIOSII processor," which can be found here: [NIOSII_Project_CPEN_430]

[NIOSII_Project_CPEN_430]: https://github.com/Gonzaga-2024-CPEN-Projects/NIOSII_Project_CPEN_430