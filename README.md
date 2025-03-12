
# Async FIFO

## Overview

This repository contains an implementation of an Asynchronous FIFO (First-In, First-Out) buffer in HDL. The FIFO is designed to handle data transfer between two clock domains with different frequencies, ensuring reliable and efficient communication.



## Features

1. Fully asynchronous design: Supports different clock domains for read and write operations.

2. Configurable depth and width: Parameterized FIFO depth and data width.

3. Gray code pointer synchronization: Ensures reliable data transfer between clock domains.

4. Flags for full and empty conditions: Helps manage FIFO status efficiently.

5. Supports different word sizes: Customizable word width based on system requirements.
## Acknowledgements

 - [ZipCPU](https://zipcpu.com/blog/2018/07/06/afifo.html)
 - [Sunburst](https://www.sunburst-design.com/papers/CummingsSNUG2002SJ_FIFO1.pdf)
 - [Karthik Vippala](https://www.youtube.com/watch?v=0LVHPRmi88c)


## License

[MIT](https://github.com/karthik5102001/Asynchronous-FIFO?tab=MIT-1-ov-file#MIT-1-ov-file)

