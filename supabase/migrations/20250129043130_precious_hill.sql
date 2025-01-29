/*
  # Clear points leaderboard
  
  1. Changes
    - Truncate the points_leaderboard table to clear all existing entries
    - This is needed because we updated the points calculation rate
  
  2. Security
    - Maintains existing RLS policies
    - No security changes needed
*/

TRUNCATE TABLE points_leaderboard;