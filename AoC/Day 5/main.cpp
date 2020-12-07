#include <iostream>
#include <vector>
#include <fstream>

int main() {
  auto IDs = std::vector<int>(); // the IDs
  IDs.resize(0x400, 0); // resize to the max amount of IDs
  auto stream = std::ifstream("input.in"); // open input file
  std::string str;

  auto beegestID = 0; // the beegestID we've found yet
  auto mySeat = 0;

  while (stream >> str) { // load elements into bitset vector
    auto id = 0; // current ID
    for (auto i = 0; i < 10; i++) { // R and B are just fancy letterss for "bit is 1"
        if (str[i] == 'R' || str[i] == 'B')
            id |= (1 << (9-i)); // the bits are also inverted for some reason
    }

    beegestID = std::max(beegestID, id); // If id > beegestID => beegestID = id
    IDs[id] = id; // push the current ID to the list of IDs
  }

  // Task 2
  // This breaks if our seat is 0, but the assignment specifically says it's not at the front or back
  for (auto i = 1; i <= 0x3FF; i++) { // find our seat
      if (!IDs[i] && IDs[i + 1] && IDs[i - 1]) { // if a seat is empty (0) and the seats before and after aren't, it's our seat
        mySeat = i; 
        break;
      }
  }

  printf("Beegest ID: %d\n", beegestID);
  printf("My seat is %d\n", mySeat);
}