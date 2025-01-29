/*
  # Create Points Leaderboard Table

  1. New Tables
    - `points_leaderboard`
      - `address` (text, primary key) - The wallet address
      - `points` (double precision) - Total points earned
      - `last_updated` (timestamptz) - Last time the points were updated

  2. Security
    - Enable RLS on `points_leaderboard` table
    - Add policy for public read access
    - Add policy for authenticated users to update their own records
*/

CREATE TABLE IF NOT EXISTS points_leaderboard (
  address text PRIMARY KEY,
  points double precision NOT NULL DEFAULT 0,
  last_updated timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE points_leaderboard ENABLE ROW LEVEL SECURITY;

-- Allow anyone to read the leaderboard
CREATE POLICY "Anyone can read leaderboard"
  ON points_leaderboard
  FOR SELECT
  TO public
  USING (true);

-- Allow authenticated users to update their own records
CREATE POLICY "Users can update their own points"
  ON points_leaderboard
  FOR ALL
  TO authenticated
  USING (auth.uid()::text = address)
  WITH CHECK (auth.uid()::text = address);