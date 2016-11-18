import Foundation
import Alamofire
class DribbleFollowers {
    // let accesToken = "3f5b8b149a5a70351e114f3911be7e9910ff3154e0ae9f08061e1064b503e67d"
    func loadFollowers(completion: (([Follower])-> Void)!, url : String) {
        let urlString = url+"?access_token=\(myToken)"
        Alamofire.request(.GET, urlString).responseJSON{ respons in
            let JsonResult = respons.2.value as! NSArray!
            var folowers = [Follower]()
            for folower in JsonResult!{
                  folowers.append(Follower(data: folower as! NSDictionary))
            }
            let priority  = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                dispatch_async(dispatch_get_main_queue()){
                    completion(folowers)
                }}
        }
        
    }
}