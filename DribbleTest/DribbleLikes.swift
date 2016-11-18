import Foundation
import Alamofire
class DribbleLikes{
    func loadFollowers(completion: (([Like])-> Void)!, url : String) {
        let urlString = url+"?access_token=\(myToken)"
        Alamofire.request(.GET, urlString).responseJSON{ respons in
            let JsonResult = respons.2.value as! NSArray!
            var likes = [Like]()
            if JsonResult != nil
            {
                for like in JsonResult!{
                    likes.append(Like(data: like as! NSDictionary))
                }
            }
            else
            {
                likes.append(Like())
            }
            let priority  = DISPATCH_QUEUE_PRIORITY_DEFAULT
            dispatch_async(dispatch_get_global_queue(priority, 0)) {
                dispatch_async(dispatch_get_main_queue()){
                    completion(likes)
                }}
        }
        
    }
}