本工程为基于高德地图iOS 定位SDK进行封装，实现了后台定位功能。
## 前述 ##
- [高德官网申请Key](http://lbs.amap.com/dev/#/).
- 阅读[开发指南](http://lbs.amap.com/api/ios-location-sdk/summary/).
- 工程基于iOS 定位SDK实现.

## 功能描述 ##
通过定位SDK后台定位功能进行后台定位展示。

## 核心类/接口 ##
| 类    | 接口  | 说明   | 版本  |
| -----|:-----:|:-----:|:-----:|
| AMapLocationManager	| - (void)startUpdatingLocation; | 连续定位接口 | v2.0.0 |
| AMapLocationManager	| BOOL pausesLocationUpdatesAutomatically; | 定位是否会被系统自动暂停 | v2.0.0 |
| AMapLocationManager	| BOOL allowsBackgroundLocationUpdates; | 是否允许后台定位 | v2.0.0 |

## 核心难点 ##

```
/* 设置后台定位. */
- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
}

//开始进行连续定位
[self.locationManager startUpdatingLocation];
```
