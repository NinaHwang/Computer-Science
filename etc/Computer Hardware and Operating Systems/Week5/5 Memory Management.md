# 5. Memory Management

Created: December 27, 2021 8:27 PM
Lecture: Computer Hardware and Operating Systems
Type: CS, Lecture

## Reasons for Memory Management

In a multiprogramming system, there will never be enough main memory

The OS will need to allocate memory to multiple programs running in the system

The OS will need to move parts between main memory and secondary memory → virtual memory

## Memory Management Requirements

Relocation

- A process could be loaded into any location in main memory
- If we look at an application’s position in main memory-its physical location-and main memory that the application has to understand that it is going to be moved at some point throughout its lifecycle → while it is running the OS pick it up and move it to a different portion of main memory

Protection ⇒ segregating each process

- A process cannot work outside of its own memory space
- A process should not be allowed to access memory outside of its allocation
- The OS cannot pre-screen the memory accesses, it must be done dynamically

Sharing

- Some processes might use the same code/data
- 크롬 브라우저를 두 개 실행한다고 했을 때 → 메인메모리에 코드를 두 번 로드하고 싶지 않음 → 한 번만 로드하고 코드를 share → 동시에 protection도 해야함

Logical Organization

- Modules, Shared Objects or Dynamically linked libraries should be allowed

⇒ The OS provides services so that programs don’t have to rewrite all the libraries

## Logical Vs. Physical Addresses

The applications really can’t make any use of physical locations as they did back in the days of batch multi-programming

Due, primarily, to relocation, a program will have to use a logical address to access memory

Logical addresses need to be converted, dynamically, to physical addresses

A simple solution to logical addresses could be the offset from the beginning of the program

The CPU’s **hardware memory management unit** is responsible for converting, during runtime, the logical address to a physical address

### Partitioning Strategies

→ we don’t choose only one among these.. for the overall main memory strategy, we might choose just one of these, however in different components of the OS we are going to have to solve a lot of different problems.. and each of these might be useful in solving an individual problem!

**Fixed Partitioning**

⇒ only for small applications

- Main memory is divided into a static number of parts
- A process will be allocated one part of equal or greater size than it needs
- Equal sized partitioning causes internal fragmentation
    - internal fragmentation: wasted space inside the partition
- Unequal sized partitioning
    - Needs to worry about which partition to place the process in

**Dynamic Partitioning**

- Partitions are created for exactly as much memory as the process needs
- Causes external fragmentation - wasted memory between allocations
    
    ![Untitled](5%20Memory%20Management%2048e456b3cae44a229923f86678db4755/Untitled.png)
    
- Requires compaction, a costly process → move C down to be adjacent to A → we have to move byte to byte
- OS data structures are complex because a process could start anywhere
- Where does the OS place a partition?
    - Best-Fit: The area with the size closest(causes external fragmentation)
    - First-Fit: Just choose the first spot in memory large enough
    - Next-Fit: Begin looking from the location of last allocation

**Buddy System**

![Untitled](5%20Memory%20Management%2048e456b3cae44a229923f86678db4755/Untitled%201.png)

[Operating System | Buddy System - Memory allocation technique - Tutorialspoint.dev - TutorialsPoint.dev](https://tutorialspoint.dev/computer-science/operating-systems/operating-system-buddy-system-memory-allocation-technique)

- A compromise between fixed and dynamic
- Memory is divided and divided again in multiples of 2
- Both internal and external fragmentation
- If we have a large number processes we would further divided the larger partitions to accommodate the need
- This makes the OS structure easier because processes begin and end on a 2^n boundary

**Simple Paging**

[Paging in Operating System - GeeksforGeeks](https://www.geeksforgeeks.org/paging-in-operating-system/)

- Memory is broken down into all equal sized frames
- A process is broken down into the same sized pages
- Since this is RAM, no frame is better suited for the task of storing the page than any other, all have O(1) access time
- Pages are loaded into non-contiguous frames
- The OS records the frame number for each page in a Page Map Table stored in the PCB

![Untitled](5%20Memory%20Management%2048e456b3cae44a229923f86678db4755/Untitled%202.png)

- The hardware MMU needs to be able to query the PMT so the format has to be agreed on
- Benefits of Paging
    - No external fragmentation(no frame is more beneficial than others)
    - A minimum of internal fragmentation → frame is small
    - Easy protection
    - Easy relocation
    - Easy sharing → copy frame numbers to all of the page map tables for the other process
- Converting Logical to Physical
    - The logical address is relative to the start of the process
    - To calculate the PAGE number, we do bit shifts because pages are always multiples of 2
    - To calculate the OFFSET into the page, we can use an XOR
    - The page number can be use as an index(like in an array) into the PMT to find the Frame number in main memory
    - The CPU will then bit shift that frame number and add the offset to find the physical address

**Simple Segmentation**

- As we have a smaller page size, we’re going to have a lot more pages for large processes
- Each process is divided into unequal sized partitions
- Storage is similar to Dynamic Partitioning

## Virtual Memory

Main memory has a limited quantity and eventually it will run out

Virtual Memory: assumes paging or segmentation

Since the process will only ever access one memory location at a given time, the rest of the memory of the process doesn’t need to be in MAIN memory

We can swap pages of the process out onto the secondary storage device and bring them back later, if needed

### What Stays?

Secondary storage device에서 가져오는 것은 시간이 걸림 → 어떤 것을 메인메모리에서 제거해 secondary storage device에 넣을지를 잘못 결정하면 시간이 낭비됨(block the process, offload the page, realize that it’s the incorrect page, and then reload it back)

Resident Set - That portion of the process in main memory

Working Set - That portion of the process which is in use

→ in order for the process to run, the working set must be in the resident set

The PMT contains a “Preset” bit to indicate what pages are present in main memory

The PMT contain a “Modify” bit to indicate if the copy of the page on the hard drive is the same as the copy in memory

- if something hasn’t been modified in a while and we already have a copy of that thing on a secondary storage device, then there’s no need to write it out to the secondary storage device in order to remove it from main memory

If the MMU encounters a page which the process wants but is NOT in the resident set, it is called a “Page fault” and the CPU switches to running the OS(like an interrupt)

### Benefits of VM

The programmer perceives a much larger memory space

The system can remove unused pages

More processes can run in the system resulting in better performance

### Lookup Problems

Now any memory access by the process requires that the MMU determine the physical address, which requires a query to the PMT

Each memory access requires two memory access

To save time, the CPU implements a Translation Lookaside Buffer which is a type of content addressable memory which stores a cache of those entries in the PMT which have been retrieved recently

![Untitled](5%20Memory%20Management%2048e456b3cae44a229923f86678db4755/Untitled%203.png)

*TLB: translation lookaside buffer*

[빽 투더 기본기 [OS 7편]. 메모리 관리 2](https://dailyheumsi.tistory.com/138)

## Replacement Policy

When main memory runs out, the OS needs to remove some pages, this is called stealing

- Main memory can never reach a 100% utilized. Because if it did, what that would mean is that there’s no storage available for immediate need, even of the operating system

If we choose poorly, the result will be worse performance

The optimal choice would be to steal the page which is not going to be used for the longest period of time

**Possible Algorithms**

[Page Replacement Algorithms in OS - Simple Explanation](https://technobyte.org/page-replacement-algorithms-in-os/)

- Optimal: not feasible
- LRU(least recently used): not feasible... we would need a timestamp of every memory access that’s done for every page in main memory → slows down the CPU
- FIFO: easy to implement but poor performance.. we’re not going to recognize pages that actively in use and that are there because we need them frequently
- Clock: easy to implement but requires USE bits.. doesn’t degrade the performance of the TLB. when something is loaded from the page map table into the TLB, its USE bit is set to one. and we can utilized them to make some estimates about what’s gonna be used and what might not be used recently ⇒ very popular recently!

### Clock Page Replacement Algorithm

![Untitled](5%20Memory%20Management%2048e456b3cae44a229923f86678db4755/Untitled%204.png)

## Resident Set Management

Two problems

- how much main memory does each process deserve
    - smaller allocations mean more processes
    - larger allocations means less page faults
- when its time to steal, which process do we steal from?
    - local: the process page faulting will lose a page
    - global: any process can lose a page

### Controlling Page Faults by Resident Set Size

There’s a non linear progression between these two points:

- If a process fits entirely in main memory, it will not generate any page faults
- If a process only has one frame, it will generate the maximum number of page faults
    - Thrashing: a constant storing and recovery of pages to and from the secondary storage device

![Untitled](5%20Memory%20Management%2048e456b3cae44a229923f86678db4755/Untitled%205.png)

### PFF (Page Fault Frequency) Algorithm

[PFF (Page Fault Frequency) > 도리의 디지털라이프](http://blog.skby.net/pff-page-fault-frequency/)

Examine the time between the last page fault and the current one

- If less than a preset F value, add a frame
- If greater than the preset F value, discard all pages with USE bit 0, reset all USE bits to 0 and continue

Upper bounds and lower bounds would be better than just F

Unfortunately, it performs poorly during locality shifts

### VSWS Algorithm

VSWS (the Variable-Interval Sampled Working Set) solves PFF’s problems by setting:

- a minimum value for clearing unused pages(M)
- a minimum number of page faults which much have occurred before clearing unused pages(Q)
- a maximum duration before clearing unused pages(L)

Below M time units, always add a frame

Between M and L:

- if there have been less than Q page faults, add a frame
- else, discard unused pages, reset USE bits, and reset the timer and Q counter

At L, discard unused pages, reset USE bits, and rest the timer and Q counter

### Load Control

Load control decides how many processors are in main memory at any given time

If we have too many page faults, it might be advantageous to remove some processes altogether, swapping

Which process do we choose?

- Lowest priority
- Faulting process: greater probability that it does not have working set resident
- Last process activated: least likely to have working set resident
- Process with smallest local resident set
- Largest Process - Most Bang for Buck
- Process with largest remaining execution window

### Shared Pages

Using virtual memory and/or paging, we can understand how sharing of structures can occur, both processes have entries in their page table for the same frames

- Code: since code doesn’t change, sharing of code pages is easy
- Data: since data changes frequently we can adopt a Copy On Write scenario

Copy On Write - Allows sharing of pages

![Untitled](5%20Memory%20Management%2048e456b3cae44a229923f86678db4755/Untitled%206.png)

- the page table is expanded to allow a “read only” attribute
- if a page is marked RO, any attempt to change that page will result in a trap to the OS
- the OS can then copy the page and mark both the original and the copy as RW since its no longer shared

### Unix FORK Function

Useful in systems which don’t have thread support, the UNIX fork function creates an exact duplicate copy of the current process

This is most easily done by creating a new process, and of course a new page table, but duplicating the data in the original page table

⇒ literally copy just the page map table and set every bit Copy On Write so that every bit(page) becomes read-only