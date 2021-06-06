//
//  MService.swift
//
//  Created by Huy Nguyen on 10/6/17.
//  Copyright © 2017 Poeta. All rights reserved.
//

import Foundation
import Alamofire

let baseURL = "http://online.meatworksasia.com/gettable.aspx?token=1234abcd&ac=gettable1&sql="
let apiURL = "http://online.meatworksasia.com/shopaction.aspx"
let findApiUrl = "https://script.google.com/macros/s/AKfycbzaMKzeGEpX3xpIVd7K-zaVpxSs7C_tVur0UlxFzdHfq9yKaXV2-fMlIMhqGHFkHq7i/exec?cmd=findUrl&name=MeatWorks"

let sqlGetNewProducts = "SELECT d2.parent_id, d2.unit_price, d2.product_id, d2.product_name, d2.photo, d2.currency_id, d3.unit_name, d3.unit_id from bzb_product d2 left outer join bzb_product_unit d3 on d2.unit_id=d3.unit_id where is_favorite =1 and is_category=0 AND is_product=1 and d2.status=0 and onsale=1 and d2.inactive=0 and d2.pos_id='ROOT' and d2.photo != ''"

let beverageType = "b4969322-4d8b-4238-81cb-1447b8bd3cd2"
let sqlGetCategories = "select id as type_id, name as type_name, product_id, product_name, photo from bzb_product d1 right outer join (select product_id as id, product_name as name from bzb_product where parent_id ='' and status =0 and onsale =1) d2 on (d1.parent_id=d2.id) where id != '%@' and status =0 and photo != '' and onsale =1 order by d2.id, order_by".format(parameters: beverageType)

let sqlGetListProduct = "SELECT  d2.product_name, lg.contents AS product_name_lg, d2.product_code , bzb_product_assign.unit_price, bzb_product_assign.product_id, d2.photo, bzb_product_assign.currency_id, d3.unit_name, d3.unit_id, d3.parent_id FROM bzb_product_assign LEFT OUTER JOIN bzb_product d2 ON(bzb_product_assign.product_id = d2.product_id) LEFT OUTER JOIN bzb_product_unit d3 ON(d2.unit_id = d3.unit_id) LEFT OUTER JOIN bzb_page lg ON(d2.product_id = lg.page_for_id AND lg.column_name='product_name' AND lg.lg='en') WHERE d2.is_category=0 AND d2.is_product=1 AND bzb_product_assign.pos_id ='ROOT' AND bzb_product_assign.status =0 and photo != '' AND bzb_product_assign.onsale = 1 AND bzb_product_assign.inactive =0 AND d2.parent_id="

let sqlGetCartItem = "SELECT d2.product_code, d2.product_name, d1.input_quantity, d1.quantity , d1.unit_price , d1.currency_id, d1.sale_detail_id, d2.photo, d1.product_id, d4.unit_name FROM bzb_product_sale_detail_local d1 LEFT OUTER JOIN bzb_product d2 ON(d1.product_id = d2.product_id) LEFT OUTER JOIN bzb_product_sale_local d3 ON(d1.sale_id = d3.sale_id) LEFT OUTER JOIN bzb_product_unit d4 ON(d1.input_unit_id = d4.unit_id) LEFT OUTER JOIN bzb_page lg ON(d2.product_id = lg.page_for_id AND lg.column_name='product_name' AND lg.lg='vn') WHERE d3.sale_id ='%@' AND d1.status =0 AND d3.status =0 ORDER BY d1.record_add DESC"

let sqlGetGroupUnit = ""
let sqlGetListPos = "select pos_id, pos_code, pos_name, tel, logo from bzb_pos where parent_id='ROOT' and order_online='1' and status='0' and inactive='0'"

class MService {
    
    static let shared = MService()
    
    var storeUrl: String = ""
    
    func request (url: URLConvertible, method: HTTPMethod, params: [String: Any]?, completion: @escaping (_ response: String?, _ error: Error?) -> Void) {
        initStoreUrl()

        Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: nil).responseString { (response) in
            guard response.result.isSuccess else {
                completion(nil, response.result.error)
                return
            }
            
            guard let dataResponse = response.data, let data = String.init(data: dataResponse, encoding: .utf8) else {
                completion(nil, response.result.error)
                return
            }
            completion(data, nil)
//            self.mwApiCall(data: data)
        }
    }
    
    func initStoreUrl() -> Void {
        if (!storeUrl.isEmpty) {
            return
        }
        guard let url =  URL(string: findApiUrl) else {
            return
        }
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (resp) in
            guard resp.result.isSuccess else {
                return
            }
            
//            guard let dataResponse = resp.data, let data = String.init(data: dataResponse, encoding: .utf8) else {
//                return
//            }
            let json = resp.result.value as? NSDictionary
            self.storeUrl = json?["data"] as? String ?? ""
        }
    }
    
    func mwApiCallOld(cmd: String, data: String) {
        let path = "https://script.google.com/macros/s/AKfycbzQF0ZXf0z2PP5kQ1UjrtPqru0OQze8kXidVxL9M9bW5qfEqmSzBMKFKg-QuH6VEMD8nw/exec?cmd=add"
        debugPrint("Test Url: \(path)")
        guard let url = URL(string: path) else {
            return
        }
        let body = data.data(using: .utf8)! as Data
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.httpBody = body
        debugPrint("MW Test - Req: \(String.init(data: body, encoding: .utf8))")
        Alamofire.request(request).responseJSON { (resp) in
            debugPrint("MW Test - Resp.data: \(resp.data)")
            debugPrint("MW Test - Resp.response: \(resp.response)")
            guard let data = resp.data else {
                return
            }
            debugPrint("MW Test - Resp.data: \(String.init(data: data, encoding: .utf8))")
        }
    }
        
    func mwApiCall2(cmd: String, data: [String:Any]?) {
        let path = "https://script.google.com/macros/s/AKfycbzQF0ZXf0z2PP5kQ1UjrtPqru0OQze8kXidVxL9M9bW5qfEqmSzBMKFKg-QuH6VEMD8nw/exec?cmd=\(cmd)"
        debugPrint("Test Url: \(path)")
        guard let url = URL(string: path) else {
            return
        }
        debugPrint("Test req: \(data)")
        Alamofire.request(url, method: .post, parameters: data, encoding: JSONEncoding.default, headers: nil).responseJSON { (resp) in
            guard resp.result.isSuccess else {
                debugPrint(resp.result.error.debugDescription)
                return
            }

//            guard let dataResponse = resp.data, let data = String.init(data: dataResponse, encoding: .utf8) else {
//                return
//            }
//            let json = resp.result.value as! NSDictionary
            debugPrint("Test resp: \(resp.result.value)")
        }
    }
        
    func mwApiCall(cmd: String, data: [String:Any]?) {
        var params: String
        if (storeUrl.contains("?")) {
            params = "&cmd=\(cmd)"
        } else {
            params = "?cmd=\(cmd)"
        }
        let path = storeUrl.appending(params)
        guard let url = URL(string: path) else {
            return
        }
        request(url: url, method: .post, params: data) { (resp, err) in
            debugPrint("MW Test - Resp: \(resp)")
//            debugPrint("MW Test - Resp.response: \(resp.response)")
//            guard let data = resp.data else {
//                return
//            }
//            debugPrint("MW Test - Resp.data: \(String.init(data: data, encoding: .utf8))")
        }
    }
        
    func getPOS(completion: @escaping (_ datas: [Country]?, _ error: Error?) -> ()) {
        
        let sqlBase64 = sqlGetListPos.getBase64()
        let path = baseURL.appending(sqlBase64)
        
        guard let url = URL(string: path) else {
            completion(nil, nil)
            return
        }
        
        var datas: [Country] = []
        
        request(url: url, method: .get, params: nil) { (response, error) in
            
            if let jsonArr = response?.components(separatedBy: "\n") {
                
                var keys: [String] = []
                
                for (index, value) in jsonArr.enumerated() {
                    
                    //Key array
                    if index == 0 {
                        keys = value.components(separatedBy: "\t")
                    } else {
                        let data = Country.init(keys: keys, values: value.components(separatedBy: "\t"))
                        datas.append(data)
                        
                    }
                }
            }
            completion(datas, error)
        }
    }
    
    func getNewProducts(completion: @escaping (_ datas: [Product]?) -> ()) {
        
        let sqlBase64 = sqlGetNewProducts.getBase64()
        let path = baseURL.appending(sqlBase64)
        
        guard let url = URL(string: path) else {return}
        
        var datas: [Product] = []
        
        request(url: url, method: .get, params: nil) { (response, error) in
            
            if let jsonArr = response?.components(separatedBy: "\n") {
                
                var keys: [String] = []
                
                for (index, value) in jsonArr.enumerated() {
                    
                    //Key array
                    if index == 0 {
                        keys = value.components(separatedBy: "\t")
                    } else {
                        
                        let data = Product.init(keys: keys, values: value.components(separatedBy: "\t"))
                        datas.append(data)
                        
                    }
                }
            }
            completion(datas)
        }
    }
    
    func getCategories(completion: @escaping (_ datas: [Category]?) -> ()) {
        
        let sqlBase64 = sqlGetCategories.getBase64()
        let path = baseURL.appending(sqlBase64)
        
        guard let url = URL(string: path) else {return}
        
        var datas: [Category] = []
        
        request(url: url, method: .get, params: nil) { (response, error) in
            
            if let jsonArr = response?.components(separatedBy: "\n") {
                
                var keys: [String] = []
                
                for (index, value) in jsonArr.enumerated() {
                    
                    //Key array
                    if index == 0 {
                        keys = value.components(separatedBy: "\t")
                    } else {
                        
                        let data = Category.init(keys: keys, values: value.components(separatedBy: "\t"))
                        datas.append(data)
                        
                    }
                }
                
                completion(datas)
            }
        }
    }
    
    func getListProduct(categoryId: String, completion: @escaping (_ datas: [Product]?) -> ()) {
        
        let sqlFinal = sqlGetListProduct + "'\(categoryId)'"
        let sqlBase64 = sqlFinal.getBase64()
        let path = baseURL.appending(sqlBase64)
        
        guard let url = URL(string: path) else {return}
        
        var datas: [Product] = []
        
        request(url: url, method: .get, params: nil) { (response, error) in
            
            if let jsonArr = response?.components(separatedBy: "\n") {
                
                var keys: [String] = []
                
                for (index, value) in jsonArr.enumerated() {
                    
                    //Key array
                    if index == 0 {
                        keys = value.components(separatedBy: "\t")
                    } else {
                        
                        let data = Product.init(keys: keys, values: value.components(separatedBy: "\t"))
                        datas.append(data)
                        
                    }
                }
                
                completion(datas)
            }
        }
    }
    
    func getGroupUnit(unitId: String, completion: @escaping (_ datas: [GroupUnit]?) -> ()) {
        
        let sqlGetGroupUnit = "select d1.parent_id, d1.unit_id, d1.unit_name, d1.group_name, d1.factor from bzb_product_unit d1, (select * from bzb_product_unit where unit_id='\(unitId)') d2 where d1.unit_id=d2.unit_id or d1.parent_id=d2.unit_id or (d2.parent_id<>'' and (d1.unit_id=d2.parent_id or d1.parent_id=d2.parent_id))"
        
        let sqlBase64 = sqlGetGroupUnit.getBase64()
        let path = baseURL.appending(sqlBase64)
        
        guard let url = URL(string: path) else {return}
        
        var datas: [GroupUnit] = []
        
        request(url: url, method: .get, params: nil) { (response, error) in
            
            if let jsonArr = response?.components(separatedBy: "\n") {
                
                var keys: [String] = []
                
                for (index, value) in jsonArr.enumerated() {
                    
                    //Key array
                    if index == 0 {
                        keys = value.components(separatedBy: "\t")
                    } else {
                        
                        let data = GroupUnit.init(keys: keys, values: value.components(separatedBy: "\t"))
                        datas.append(data)
                        
                    }
                }
                completion(datas)
            }
        }
    }
    
    func getCartItems(saleId: String, completion: @escaping (_ datas: [Cart]?, _ err: Error?) -> ()) {
        
        let sqlFinal = sqlGetCartItem.format(parameters: saleId)
        let sqlBase64 = sqlFinal.getBase64()
        let path = baseURL.appending(sqlBase64)
        
        guard let url = URL(string: path) else {return}
        
        var datas: [Cart] = []
        
        request(url: url, method: .get, params: nil) { (response, error) in
            
            if let jsonArr = response?.components(separatedBy: "\n") {
                
                var keys: [String] = []
                
                for (index, value) in jsonArr.enumerated() {
                    
                    //Key array
                    if index == 0 {
                        keys = value.components(separatedBy: "\t")
                    } else {
                        let data = Cart.init(keys: keys, values: value.components(separatedBy: "\t"))
                        datas.append(data)
                    }
                }
            }
            if datas.isEmpty {
                completion(nil, MWError("System error, can't fetch data. Please try again later"))
            } else {
                completion(datas, error)
            }
        }
    }
    
    func getSale(pos_id: String, completion: @escaping (_ sale_Id: String?, _ err: Error?) -> ()) {
        let path = apiURL.appending("?action=addSale&pos_id=\(pos_id)")
        guard let url = URL(string: path) else {return}
        request(url: url, method: .get, params: nil) { (response, error) in
            completion(response, error)
        }
    }
    
    func addProduct(sale_id: String, pos_id: String, data: String, completion: @escaping (_ saleDetailId: String?, _ err: Error?) -> ()) {
        let query = "action=AddProduct&sale_id=\(sale_id)&pos_id=\(pos_id)&sData=\(data)"
        let path = apiURL.appending("?").appending(query)
        guard let url = URL(string: path) else {return}
        request(url: url, method: .get, params: nil) { (response, error) in
            if response?.components(separatedBy: "-").count ?? 0 > 2 {
                completion(response, error)
            }
            else {
                completion(nil, MWError("Can't add this product to cart, please try again later"))
            }
        }
    }
    
    func removeProduct(sale_detail_id: String, pos_id: String, completion: @escaping (_ success: String?) -> ()) {
        
        let path = apiURL.appending("?action=removeProduct&pos_id=\(pos_id)&sale_detail_id=\(sale_detail_id)")
        guard let url = URL(string: path) else {return}
        request(url: url, method: .get, params: nil) { (response, error) in
            completion(response)
        }
    }
    
    func postOrder(sale_id: String, fullName: String, phone: String, address: String, direction: String, completion: @escaping (_ success: String?, _ err: Error?) -> ()) {
        let path = "\(apiURL)?action=checkout"
            .appending("&sale_id=").appending(sale_id)
            .appending("&delivery_name=").appending(fullName.urlEncoded())
            .appending("&delivery_tel=").appending(phone)
            .appending("&delivery_to=").appending(address.urlEncoded())
            .appending("&delivery_direction=").appending(direction.urlEncoded())
        guard let url = URL(string: path) else {
            completion(nil, nil)
            return
        }
        request(url: url, method: .get, params: nil) { (response, error) in
            completion(response, error)
        }
    }
}

extension String {
    func urlEncoded() -> String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}
