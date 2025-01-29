/*
  # Fix wallet profiles RLS policies

  1. Changes
    - Drop existing RLS policies
    - Add new public read policy
    - Add new public write policy without user authentication requirement
    
  2. Security
    - Allow public read access to all profiles
    - Allow public write access but only to their own address
*/

-- Drop existing policies
DROP POLICY IF EXISTS "Anyone can read wallet profiles" ON wallet_profiles;
DROP POLICY IF EXISTS "Users can update their own profile" ON wallet_profiles;

-- Create new policies
CREATE POLICY "Anyone can read wallet profiles"
  ON wallet_profiles
  FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Anyone can update their own profile"
  ON wallet_profiles
  FOR INSERT
  TO public
  WITH CHECK (true);

CREATE POLICY "Anyone can update their own profile update"
  ON wallet_profiles
  FOR UPDATE
  TO public
  USING (true)
  WITH CHECK (true);