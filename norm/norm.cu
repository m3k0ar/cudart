#include <cmath>
#include <thrust/transform_reduce.h>
#include <thrust/functional.h>
#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
using namespace thrust;
using namespace thrust::placeholders;

int main(int argc, char* argv[])
{
	// Initialize host data.
	float h[4] = {1.0, 2.0, 3.0, 4.0};

	// Copy data from host to device.
	device_vector<float> d(h, h + 4);

	// Compute norm square.
	float norm2 = transform_reduce
	(
		d.begin(), d.end(), // Data range.
		_1 * _1,            // Unary transform operation.
		0,                  // Initial value of the reduction.
		plus<float>()       // Binary operation used to reduce values.
	);

	// Compute norm.
	float norm = std::sqrt(norm2);

	// Print the norm.
	std::cout << norm << std::endl;
}
