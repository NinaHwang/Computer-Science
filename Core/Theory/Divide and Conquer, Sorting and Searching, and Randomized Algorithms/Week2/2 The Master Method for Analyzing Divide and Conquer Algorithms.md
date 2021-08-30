# 2. The Master Method for Analyzing Divide and Conquer Algorithms

Created: August 2, 2021 3:45 PM<br>
Lecture: Divide and Conquer Sorting and Searching and Randomized Algorithms<br>
Materials: https://www.coursera.org/learn/algorithms-divide-conquer/home/week/2, https://www.geeksforgeeks.org/closest-pair-of-points-onlogn-implementation/<br>
Type: Lecture

# Divide & Conquer Algorithms

## O(n log n) Algorithm for Counting Inversions

### The divide and conquer paradigm

1. DIVIDE into smaller sub problems
2. CONQUER via recursive calls
3. COMBINE solutions of subproblems into one for the original problem

### The Problem

Input: array A containing the numbers 1,2,3... ,n in some arbitrary order

Output: number of inversions = number of pairs(i, j) of array indices with i < j and A[i] > A[j]

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-02_at_15.55.27.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-02_at_15.55.27.png)

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-02_at_16.09.08.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-02_at_16.09.08.png)

```
Count(array A, length n)
	if n=1, return 0
	else
		X = Count (1st half of A, n/2)
		Y = Count (2nd half of A, n/2)
		Z = CountSplitInv(A,n) # currently unimplemented
	return x+y+z
```

Goal: implement CountSplitInv in linear O(n) time ⇒ then Count will run in O(n log n) time(just like merge sort).

### Piggybacking on Merge Sort

KEY IDEA: have recursive calls both count inversions and sort

```
D = output [length=n]
B = 1st sorted array[n/2]
C = 2nd sorted array[n/2]
i = 1
j = 1

for k=1 to n
	if B(i) < C(j)
		D(k) = B(i)
		i++
	else if C(j) < B(i)
		D(k) = C(j)
		j++
```

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-02_at_16.22.17.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-02_at_16.22.17.png)

Claim: the split inversions involving an element y of the 2nd array C are precisely the numbers left in the 1st array B when y is copied to the output D

Proof: let x be an element of the 1st array B

- if x copied to output D before y, then x < y ⇒ no inversion involving x & y
- if y copied to output D before x, then y < x ⇒ x & y are an inversion

Merge_and_CountSplitInv

- while merging the two sorted subarrays, keep running total of number of split inversion
- when element of 2nd array C gets copied to output D, increment total by number of elements remaining in 1st array B
- Runtime of subroutine: O(n) + O(n) = O(n) ⇒ O(n): merging, O(n): running total

## Strassen's Subcubic Matrix Multiplication Algorithm

### Matrix Multiplication

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-02_at_18.11.57.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-02_at_18.11.57.png)

The best we could really hope for a matrix multiplication algorithm would be a running time of n squared

### Applying Divide and Conquer

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-02_at_18.27.11.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-02_at_18.27.11.png)

Recursive Algorithm

1. recursively compute the 8 necessary products
2. do the necessary additions(ϴ($n^{2}$) times)

**Fact**: runtime is ϴ($n^{3}$) ⇒ no better, no worse than the straightforward iterative algorithm

### Strassen's Algorithm(1969)

1. recursively compute only 7 (cleverly chosen) products
2. do the necessary (clever) additions + subtractions(still ϴ($n^{2}$) times)

**Fact**: better than cubic time!

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-02_at_18.47.01.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-02_at_18.47.01.png)

## O(n log n) Algorithm for Closest Pair (advanced)

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_15.13.52.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_15.13.52.png)

### Initial Observations

**Assumption**: (for convenience) all points have distinct x-coordinates, distinct y-coordinates

**Brute-force search**: takes ϴ($n^{2}$) time.

**1 dimensional version of closest pair**: 

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_15.18.46.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_15.18.46.png)

1. sort points (O(n log n)time)
2. return closest pair of adjacent points (O(n) time)

**Goal**: O(n log n) time algorithm for 2D version.

### High-Level Approach

1. make copies of points sorted by x-coordinate and by y-coordinate[O(n log n) time]
2. use Divide + Conquer

### ClosestPair($P_{x}$, $P_{y}$)

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_15.53.49.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_15.53.49.png)

### ClosestSplitPair($P_{x}$, $P_{y}$,𝜹)

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_15.53.58.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_15.53.58.png)

### Correctness Claim

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_16.02.09.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_16.02.09.png)

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_17.32.52.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_17.32.52.png)

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_17.33.03.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_17.33.03.png)

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_17.33.09.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_17.33.09.png)

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_17.33.16.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_17.33.16.png)

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_17.33.23.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-03_at_17.33.23.png)

# The Master Method

**Black box** for solving recurrences 

⇒ it takes an input a recurrence in a particular format and it spits out as output a solution to that recurrence 

assumptions

- all subproblems have equal size

## Recurrence Format

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-12_at_11.48.14.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-12_at_11.48.14.png)

## The Master Method

If $T(n) ≤ aT(n/b) + O(n^{d})$ then

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-12_at_11.53.58.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-12_at_11.53.58.png)

## Example

### 1. Merge Sort

a = 2, b = 2, d = 1(linear) ⇒ $O(nlogn)$

### 2. Binary Search

a = 1 (don't need to check another half), b = 2, d = 0 ⇒  $O(nlogn)$

### 3. Integer Multiplication

a = 4

b = 2 (the input size drops by a factor 2 when recursed)

d = 1 (all it is doing is additions and adding by zeros ⇒ linear time)

⇒ $O(n^{log_{2}4}$) ⇒ $O(n^{2})$

- Gauss's Trick: a = 3, b = 2, d = 1 ⇒  $O(n^{log_{2}3}$) ⇒ $O(n^{1.59})$

### 4. Strassen's Matrix Multiplication Algorithm

a = 7 (total 7 subproblems)

b = 2

d = 2 (linear in the matrix size → quadratic in the dimension)

⇒ $O(n^{log_{2}7})$  ⇒ $O(n^{2.81})$ ⇒ beats the naive iterative algorithm($O(n^{3}$))

### 5. Fictitious Recurrence

T(n) ≤ 2T(n/2) + O($n^{2}$)

- a = 2
- b = 2
- d = 2

⇒ T(n) = $O(n^{2})$

## Proof

### Preamble

![2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-12_at_12.19.08.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-12_at_12.19.08.png)

At a given depth  $j$:

- how many distinct subproblems are there at level $j$ ⇒ $a^{j}$
- how many different level $j$ are there? ⇒ $n/b^{j}$

### The Recursion Tree

![Screen Shot 2021-08-30 at 11.39.18.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-30_at_11.39.18.png)

### Working at a Single Level

![Screen Shot 2021-08-30 at 11.42.40.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-30_at_11.42.40.png)

Interpretation:

$a$ = rate of subproblem proliferation ⇒ RSP

$b^{d}$ = rate of work shrinkage(per subproblem) ⇒ RWS 

whether RSP > RWS or RSP < RWS or RSP == RWS determines whether the amount of work increases / decreases / remains the same with the recursion level $j$. 

### Total Work

Summing over all levels of $j$:

⇒ total work ≤ $cn^{d} * \sum_{j=0}^{log_{b}n} (a/b^{d})^{j}$

- if $a == b^{d}$ :
    - $\sum_{j=0}^{log_{b}n} (a/b^{d})^{j}$ ==  $(log_{b}n + 1)$

    ⇒ $O(n^{d}logn)$ (c=constant)

Basic Sums Fact:

![Screen Shot 2021-08-30 at 13.36.54.png](2%20The%20Master%20Method%20for%20Analyzing%20Divide%20and%20Conqu%20ffdac7bef17541fbab7d10976a32b5a4/Screen_Shot_2021-08-30_at_13.36.54.png)

- if $a < b^{d}$ (RSP < RWS):
    - $\sum_{j=0}^{log_{b}n} (a/b^{d})^{j}$ → a constant

    ⇒ $O(n^{d})$ → total work dominated by top level

- if $a > b^{d}$ (RSP > RWS):
    - $\sum_{j=0}^{log_{b}n} (a/b^{d})^{j}$ → a constant * $(a/b^{d})^{log_{b}n}$

    ⇒ $O(n^{d} * (a/b^{d})^{log_{b}n})$

    ⇒ $O(a^{log_{b}n})$ == O(# of leaves)

    ⇒ $a^{log_{b}n} == n^{log_{b}a}$ (∵ $(log_{b}n)(log_{b}a) == (log_{b}a)(log_{b}n)$ )
