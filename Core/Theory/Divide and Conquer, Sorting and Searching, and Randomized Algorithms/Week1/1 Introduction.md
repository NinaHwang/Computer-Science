# 1. Introduction; "big-oh" notation and asymptotic analysis

Class: Divide and Conquer Sorting and Searching and Randomized Algorithms
Created: July 22, 2021 4:41 PM
Materials: https://www.coursera.org/learn/algorithms-divide-conquer/home/week/1, https://ko.khanacademy.org/computing/computer-science/algorithms/asymptotic-notation/a/asymptotic-notation
Type: Lecture

# Introduction

## Why Study Algorithms?

**Algorithm**: a set of well-defined rules, a recipe in effect for solving some computational problem

Why Study Algorithms?

- important for all other branches of computer science
- plays a key role in modern technological innovation
- provides novel "lens" on processes outside of computer science and technology
    - ex) quantum mechanics, economic markets, evolution..
- challenging!
- fun!

## About the Course

### Course Topics

Vocabulary for design and analysis of algorithms

- E.g., "Big-Oh" notation
- "sweet spot" for high-level reasoning about algorithms

Divide and conquer algorithm design paradigm

- Will apply to: integer multiplication, sorting, matrix multiplication, closest pair
- General analysis methods

Randomization in algorithm design

- Will apply to: QuickSort, primality testing, graph partitioning, hashing

Primitives for reasoning about graphs

- Connectivity information, shortest paths, structure of information and social networks

Use and implementation of data structures

- Heaps, balanced binary search trees, hashing and some variants
    - balanced binary search trees: dynamically maintain an ordering on a set of elements while supporting a large number of queries that run in time logarithmic in the size of the set
    - hash tables/maps: keep track of a dynamic set, while supporting extremely fast insert and lookup queries

## Merge Sort

Merge Sort algorithm is a recursive algorithm. 

- That means, that a program which calls itself and it calls itself on smaller sub problems of the same form

### Motivation

Why study merge sort?

- Good introduction to divide & conquer ⇒ improves over Selection, Insertion, Bubble sorts
- Calibrate your preparation
- Motivates guiding principles for algorithm analysis
- Analysis generalizes to "Master Method"

### The Sorting Problem

input: array of n numbers, unsorted

output: same numbers, sorted in increasing order

### Example

![1%20Introduction;%20big-oh%20notation%20and%20asymptotic%20ana%2042b818b3edf740378fd358944ddf3781/Screen_Shot_2021-07-22_at_18.33.22.png](1%20Introduction;%20big-oh%20notation%20and%20asymptotic%20ana%2042b818b3edf740378fd358944ddf3781/Screen_Shot_2021-07-22_at_18.33.22.png)

### Pseudocode

```
C = output array[length = n]
A = 1st sorted array[n/2]
B = 2nd sorted array[n/2]

i = 1
j = 1

for k = 1 to n
	if A(i) < b(j)
		C(k) = A(i)
		i++
	else if B(j) < A(i)
		C(k) = B(j)
		j++
end
				(ignores end cases)
```

Running time: $6nlog_{2}n+6n$

### Analysis

**Claim**: For every input array of n numbers, Merge Sort produces a sorted output array and uses at most $6nlog_{2}n+6n$ operations

**Proof of claim** (assuming n= power of 2) ⇒ by "recursion tree"

![1%20Introduction;%20big-oh%20notation%20and%20asymptotic%20ana%2042b818b3edf740378fd358944ddf3781/Screen_Shot_2021-07-23_at_11.26.17.png](1%20Introduction;%20big-oh%20notation%20and%20asymptotic%20ana%2042b818b3edf740378fd358944ddf3781/Screen_Shot_2021-07-23_at_11.26.17.png)

- At each level j=0,1,2,...,$log_{2}n$, there are $2^{j}$ subproblems, each of size $n/2^{j}$

![1%20Introduction;%20big-oh%20notation%20and%20asymptotic%20ana%2042b818b3edf740378fd358944ddf3781/Screen_Shot_2021-07-23_at_11.29.36.png](1%20Introduction;%20big-oh%20notation%20and%20asymptotic%20ana%2042b818b3edf740378fd358944ddf3781/Screen_Shot_2021-07-23_at_11.29.36.png)

## Guiding Principles for Analysis of Algorithms

1. Worst-case Analysis: our running time bound holds for every input of length n
- particularly appropriate for general purposes
- mathematically attractable

⇔ Average-case Analysis, Benchmarks : requires domain knowledge(e.g. what inputs are more common than others, what inputs better represent typical inputs than others...)

1. Won't pay much attention to constant factors, lower-order terms
    - Justification
        - way easier
        - constants depend on architecture / compiler / programmer any ways
        - lose very little predictive power
2. Asymptotic analysis: focus on running time for **large** input sizes n

### What Is a "Fast" Algorithm?

fast algorithm $\thickapprox$ worst-case running time grows slowly with input size

# Asymptotic Analysis

> 중요하지 않은 항과 상수 계수를 제거하면 이해를 방해하는 불필요한 부분이 없어져서 알고리즘의 실행 시간에서 중요한 부분인 성장률에 집중할 수 있습니다. 상수 계수와 중요하지 않은 항목을 제거한 것은 점근적 표기법(asymptotic notation)이라 합니다.

## The Gist

Importance : vocabulary for the design and analysis of algorithms

"sweet spot" for high-level reasoning about algorithms

coarse enough to suppress architecture / language / compiler-dependent details

sharp enough to make useful comparisons between different algorithms, especially on large inputs(e.g. sorting or integer multiplication) 

### Asymptotic Analysis

High-level idea : suppress **constant factors** and **lower-order terms**

- constant factors: too system-dependent
- lower-order terms: irrelevant for large input

example) equate $6nlog_{2}n+6n$ with just $nlogn$ ⇒ running time is $O(nlogn)$

## Big-Oh Notation

Usually, the worst-case running time of an algorithm

## Big Omega and Theta

> 특정 실행 시간이 $Θ(n)$이라고 하는 것은 $n$이 충분히 크다면 실행 시간이 어떤 상수 $k_{1}$와 $k_{2}$에 대하여 최소 $k_{1}\times n$이며 최대 $k_{2}\times n$이 된다는 뜻입니다.
big-$Θ$표기법을 사용하는 것은 실행 시간에 대해 점근적으로 근접한 한계값이 있다고 표현하는 것입니다. "점근적으로"라는 말을 쓰는 이유는 큰 값의 $n$에 대해서만 적용되기 때문입니다. "근접한 한계값"이라는 말은 위, 아래로 상수값 내에서 실행 시간을 좁힐 수 있다는 뜻입니다.

If big O is analogous to less than or equal to, then omega and theta are analogous to greater or equal to
