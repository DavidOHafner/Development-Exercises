#Author: Samantha Hafner
#Content: solves and verifies solutions to the subset-sum problem
#Intent: Solution to CSC 341 Ex-33
#Last revised: 13 Oct 2019

# subset_sum: Positive-Num × SetOf(Positive-Num) -> SetOf(Positive-Num) or False
# usage: subset_sum(target, *args) returns a subset of args which has a sum of
#  target if such a subset exists, otherwise False. If passed a multi-set instead
#  of a set, then a satisfactory multi-set will be returned if one exists
# Runtime when all inputs are integers: O(target*len(args))
# Runtime: O(2**len(args))
def subset_sum(target, *args):
    args = list(args)
    args.sort(reverse=True)
    reachable = {0:[]}
    for i in args:
        new = {}
        for j in reachable:
            if j+i <= target:
                new[j+i] = reachable[j]+[i]
            if j+i == target:
                return new[target]
        reachable.update(new)
    return reachable.get(target, False)


# check_subset_sum: Num × SetOf(Num) × SetOf(Num) -> Bool
# usage: check_subset_sum(s, target, *args) returns True iff the sum of all
#  values in s is target and s is a subset of args, otherwise False.
# Runtime: O(len(args))
def check_subset_sum(s, target, *args):
    return sum(s) == target and set(s).issubset(set(args))


# test: Positive-Int -> {'Pass.', 'Fail.'}
# usage: test(n) should return 'Pass.' for all n. It confirms the relative
#  consistency of subset_sum and check_subset_sum by checking that subsets
#  returned by subset_sum are satisfactory according to check_subset_sum and
#  that check_subset_sum does not accept subsets when none exist according to
#  subset_sum.
# Runtime: O(n**4) [empirical measurements were not inconsistent with this]
def test(n):
    from random import randint, sample
    for i in range(n):
        args = [randint(0, i**2) for j in range(i+1)]

        s = subset_sum(*args)
        if s == False:
            for j in range(100):
                if check_subset_sum(sample(args, randint(0, i)), *args):
                    print('a', *args)
                    return 'Fail.'
        else:
            if not check_subset_sum(s, *args):
                print('b')
                return 'Fail.'
    return 'Pass.'

#Copyright 2019 by Samantha Orion Hafner and released under the
#Creative Commons Attribution-ShareAlike 4.0 International License.
#To view a copy of the license, visit
#https://creativecommons.org/licenses/by-sa/4.0/
