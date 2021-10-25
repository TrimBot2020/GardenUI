nav_msgs::GetMap::Request req;
nav_msgs::GetMap::Response resp;

ROS_INFO("Requesting the map...");
while (!ros::service::call("static_map", req, resp))
{
ROS_WARN("Request for map failed; trying again...");
ros::Duration d(0.5);
d.sleep();
}
// resp.map is the map information
ROS_INFO("Created map...");
