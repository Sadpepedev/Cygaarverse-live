/*
  # Fix RLS Policies for Points Leaderboard

  1. Changes
    - Drop existing policies
    - Add new policies for:
      - Public read access (excluding Uniswap pool)
      - Public write access (excluding Uniswap pool)
    
  2. Security
    - Maintains blacklist for Uniswap pool address
    - Allows public access for both read and write operations
    - Prevents manipulation of blacklisted addresses
*/

DO $$ BEGIN
  -- Drop existing policies
  DROP POLICY IF EXISTS "Anyone can read leaderboard" ON points_leaderboard;
  DROP POLICY IF EXISTS "Users can update their own points" ON points_leaderboard;
  
  -- Create new read policy
  CREATE POLICY "Anyone can read leaderboard"
    ON points_leaderboard
    FOR SELECT
    TO public
    USING (
      address != '0xBe01179F2291773D220Eae55Ee85b417F40342d0'
    );

  -- Create new write policy
  CREATE POLICY "Anyone can update points"
    ON points_leaderboard
    FOR ALL
    TO public
    USING (
      address != '0xBe01179F2291773D220Eae55Ee85b417F40342d0'
    )
    WITH CHECK (
      address != '0xBe01179F2291773D220Eae55Ee85b417F40342d0'
    );
END $$;