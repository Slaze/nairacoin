#pragma once

// gcc 11+ stopped leaking these through other headers. CryptoNote 2016
// sources assume the old libstdc++ include graph.
#include <algorithm>
#include <chrono>
#include <functional>
#include <iostream>
#include <limits>
#include <memory>
#include <stdexcept>
#include <string>
#include <thread>
#include <vector>
