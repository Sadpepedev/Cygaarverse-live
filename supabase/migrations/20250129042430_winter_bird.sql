/*
  # Add Uniswap Pool Address Blacklist

  1. Changes
    - Add a WHERE clause to the existing public read policy to exclude the Uniswap pool address
    - Drop and recreate the policy to update the conditions
*/

DO $$ BEGIN
  -- Drop the existing policy
  DROP POLICY IF EXISTS "Anyone can read leaderboard" ON points_leaderboard;
  
  -- Recreate the policy with blacklist condition
  CREATE POLICY "Anyone can read leaderboard"
    ON points_leaderboard
    FOR SELECT
    TO public
    USING (
      address != '0xBe01179F2291773D220Eae55Ee85b417F40342d0' -- Exclude Uniswap pool
    );
END $$;