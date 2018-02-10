{-# LANGUAGE FlexibleContexts#-}
module TSP where

import DArray
import Control.Monad(forM_)

import Data.List
import Data.Maybe (fromJust)

ins x [] = [[x]]
ins x (y:ys) = [ [x,y]++ys ] ++ map (y:) (ins x ys)

perm :: [Int] -> [[Int]]
perm  [] = [[]]
perm xs = do
  a <- xs
  let m = delete a xs
  ls <- perm m
  return (a : ls)

type Matrix = [[Int]]

type Town = Int

type Tour = [Town]

-- Brute Force --
cost :: Matrix -> Tour -> Int
cost dist (x:xs) = go dist x (x:xs)
  where go d t [y] = d !! y !! t
        go d t (x:y:xs) = d !! x !! y + go d t (y:xs)

cheapP :: Matrix -> Tour -> Tour -> Ordering
cheapP m t1 t2 = compare (cost m t1) (cost m t2)

cheapest :: Matrix -> [Tour] -> Tour
cheapest m ts = head $ sortBy (\t1 t2 -> cheapP m t1 t2) ts

tsp :: Matrix -> [Int] -> Tour
tsp m xs = cheapest m $ perm xs

-- A heuristic algorithm --
nearest :: Matrix -> Town -> [Town] -> Town
nearest dm x ys = let t = dm !! x
                      s  = head $ sort $ filter (\e -> elem e ys) t
                    in fromJust $ elemIndex s t

nn :: Matrix -> [Town] -> Tour
nn dm (x:xs) = nnLoop dm xs [x]
  where nnLoop dm [] xs      = reverse xs
        nnLoop dm xs l@(y:_) = let t = nearest dm y xs
                               in nnLoop dm (delete t xs) (t:l)

--nnLoop :: Matrix -> [Town] -> Tour -> Tour
