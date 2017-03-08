


import UIKit
import JSQMessagesViewController
import Firebase
import FirebaseDatabase
//class MessageViewController: JSQMessagesViewController {
//    
//    
//    var messages: [JSQMessage]?
//    var incomingBubble: JSQMessagesBubbleImage!
//    var outgoingBubble: JSQMessagesBubbleImage!
//    var incomingAvatar: JSQMessagesAvatarImage!
//    var outgoingAvatar: JSQMessagesAvatarImage!
//    
//    func setupFirebase() {
//        
//        // 最新25件のデータをデータベースから取得する
//        // 最新のデータ追加されるたびに最新データを取得する
//        var ref = FIRDatabase.database().reference()
//        
//        ref.queryLimited(toLast: 25).observe(.childAdded, with: { (snapshot) in
//            guard let value = snapshot.value as? [String: [String]] else {
//                return
//            }
//            let sender = value["from"] as? String
//            let name = value["name"] as? String
//            let text = value["text"] as? String
//            print(snapshot.value!)
//            let message = JSQMessage(senderId: sender, displayName: name, text: text)
//            self.messages?.append(message!)
//            self.finishReceivingMessage()
//        })
//    }
//    
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//        inputToolbar!.contentView!.leftBarButtonItem = nil
//        automaticallyScrollsToMostRecentMessage = true
//        
//        
//        //自分のsenderId, senderDisokayNameを設定
//        self.senderId = "user1"
//        self.senderDisplayName = "hoge"
//        
//        //吹き出しの設定
//        let bubbleFactory = JSQMessagesBubbleImageFactory()
//        self.incomingBubble = bubbleFactory?.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
//        self.outgoingBubble = bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
//        
//        //アバターの設定
//        self.incomingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: #imageLiteral(resourceName: "Swift-Logo"), diameter: 64)
//        self.outgoingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: #imageLiteral(resourceName: "Swift-Logo"), diameter: 64)
//        
//        //メッセージデータの配列を初期化
//        self.messages = []
//        setupFirebase()
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    //Sendボタンが押された時に呼ばれる
//    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
//        
//        //メッセジの送信処理を完了する(画面上にメッセージが表示される)
//        finishSendingMessage(animated: true)
//        sendTextToDatabase(text)
//        //firebaseにデータを送信、保存する\
//    }
//    func sendTextToDatabase (_ text: String){
//        let ref = FIRDatabase.database().reference()
//        
//        let post1 = ["from": senderId, "name": senderDisplayName, "text": text]
//        let post1Ref = ref.childByAutoId()
//        post1Ref.setValue(post1)
//        
//    }
//    
//    //アイテムごとに参照するメッセージデータを返す
//   override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
//        return self.messages?[indexPath.item]
//    }
//    
//    //アイテムごとのMessageBubble(背景)を返す
//    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
//        let message = self.messages?[indexPath.item]
//        if message?.senderId == self.senderId {
//            return self.outgoingBubble
//        }
//        return self.incomingBubble
//    }
//    
//    //アイテムごとにアバター画像を返す
//    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
//        let message = self.messages?[indexPath.item]
//        if message?.senderId == self.senderId {
//            return self.outgoingAvatar
//        }
//        return self.incomingAvatar
//    }
//    
//    //アイテムの総数を返す
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return (self.messages?.count)!
//    }
//    
//    
//}

class MessageViewController: JSQMessagesViewController {
    
    var messages: [JSQMessage]?
    
    var incomingBubble: JSQMessagesBubbleImage!
    var outgoingBubble: JSQMessagesBubbleImage!
    var incomingAvatar: JSQMessagesAvatarImage!
    var outgoingAvatar: JSQMessagesAvatarImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFirebase()
        setupChatUi()
        
        messages = []
    }
    
    func setupFirebase() {
        let rootRef = FIRDatabase.database().reference()
        
        rootRef.queryLimited(toLast: 100).observe(.childAdded, with: { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                return
            }
            let text = value["text"] as? String ?? ""
            let sender = value["from"] as? String ?? ""
            let name = value["name"] as? String ?? ""
            let message = JSQMessage(senderId: sender, displayName: name, text: text)!
            self.messages?.append(message)
            self.finishReceivingMessage()
        })
    }
    
    func setupChatUi() {
        inputToolbar.contentView.leftBarButtonItem = nil
        automaticallyScrollsToMostRecentMessage = true
        
        senderId = "user1"
        senderDisplayName = "test"
        incomingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: #imageLiteral(resourceName: "Swift-Logo"), diameter: 64)
        outgoingAvatar = JSQMessagesAvatarImageFactory.avatarImage(with: #imageLiteral(resourceName: "Swift-Logo"), diameter: 64)
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        incomingBubble = bubbleFactory?.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
        outgoingBubble = bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        finishSendingMessage(animated: true)
        sendTextToDataBase(text)
    }
    
    func sendTextToDataBase(_ text: String) {
        let rootRef = FIRDatabase.database().reference()
        
        let post = ["from": senderId, "name": senderDisplayName, "text": text]
        let postRef = rootRef.childByAutoId()
        postRef.setValue(post)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages?[indexPath.item]
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        guard let message = messages?[indexPath.item], message.senderId == senderId else {
            return incomingBubble
        }
        return outgoingBubble
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        guard let message = messages?[indexPath.item], message.senderId == senderId else {
            return incomingAvatar
        }
        return outgoingAvatar
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages?.count ?? 0
    }
}


