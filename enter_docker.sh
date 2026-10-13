
#!/bin/bash

echo "To get cameras: gz topic -l | grep -E 'image|camera'"

docker exec -it px4-sitl bash
