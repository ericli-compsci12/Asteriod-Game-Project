//--------------------------------------------------------------
//**************************************************************
// THIS PAGE COUNTS HOW MANY ASTERIODS ARE LEFT
//**************************************************************
//--------------------------------------------------------------
int getAsteroidCount() {
  int count = 0;
  for (GameObject obj : objects) {
    if (obj instanceof Asteriod) {
      Asteriod a = (Asteriod) obj;
      if (a.size == 3) count += 4;      // Large asteroid
      else if (a.size == 2) count += 2; // Medium asteroid
      else if (a.size == 1) count += 1; // Small asteroid
    }
  }
  return count;
}
