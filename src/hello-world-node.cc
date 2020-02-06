#include "cuda_hello_world/hello-world-node.h"

#include <glog/logging.h>

namespace cuda {

HelloWorldNode::HelloWorldNode(
    const ros::NodeHandle& nh, const ros::NodeHandle& nh_private)
    : spinner_(1), node_handle_(nh), node_handle_private_(nh_private) {
  should_exit_.store(false);
}

bool HelloWorldNode::run() {
  LOG(INFO) << "Running CUDA Hello World example";
  spinner_.start();
  return true;
}

const std::atomic<bool>& HelloWorldNode::shouldExit() const noexcept {
  return should_exit_;
}

std::string HelloWorldNode::updateAndPrintStatistics() {
  return "";
}

void HelloWorldNode::shutdown() {}

}  // namespace cuda
