/*
  # Add wallet profiles table

  1. New Tables
    - `wallet_profiles`
      - `address` (text, primary key)
      - `display_name` (text)
      - `created_at` (timestamp)
      - `updated_at` (timestamp)

  2. Security
    - Enable RLS on `wallet_profiles` table
    - Add policy for public read access
    - Add policy for users to update their own profile
*/

CREATE TABLE IF NOT EXISTS wallet_profiles (
  address text PRIMARY KEY,
  display_name text,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

ALTER TABLE wallet_profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Anyone can read wallet profiles"
  ON wallet_profiles
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Users can update their own profile"
  ON wallet_profiles
  FOR ALL
  TO public
  USING (address = current_user)
  WITH CHECK (address = current_user);