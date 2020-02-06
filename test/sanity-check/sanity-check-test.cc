#include "cuda_hello_world/test-entrypoint.h"

#include <gtest/gtest.h>

namespace sanity {

class SanityCheckTest : public ::testing::Test {
 protected:
  virtual void SetUp() {}
};

TEST(SanityCheckTest, SanityCheck) {
  EXPECT_TRUE(true);
}

}  // namespace sanity

UNITTEST_ENTRYPOINT
