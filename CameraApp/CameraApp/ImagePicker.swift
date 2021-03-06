//
//  ImagePicker.swift
//  CameraApp
//
//  Created by Keita Shiga on 2020/08/27.
//  Copyright © 2020 Keita Shiga. All rights reserved.
//

import SwiftUI

// デリゲートとは、あるクラスだけでは処理できない命令（カメラやアルバムから写真を取得出来るが使い方は開発者に任せるため）を、そのクラスの代わりに行うクラス（開発者側に任せられたクラス）
// デリゲートは必ずプロトコルを批准する

// UIKitフレームワークのclassだから、SwiftUIフレームワークで使えるUI部品にするための橋渡しするコード
// 最終的にはAPIリファレンスだが、
// Apple DeveloperとかApple Developer Forumsとかを見る

// ImagePicker構造体は、カメラやアルバムから写真を取得することは出来るが、その写真をどのように利用するかは知らない。その処理は代理人であるCoordinatorクラスに任せる仕様。 -> 写真を取得するするためのコードは便利なクラスを提供してくれているが（UIImagePickerController）、写真をどのように扱うかは開発者ごとに異なるため、delegateという仕組みを使っている。
struct ImagePicker: UIViewControllerRepresentable {
    
    // @Bindingは親のStateをにアクセスできる
    // 通常は値渡しだが、参照渡しになり、子で変更したものは親の状態が変更される
    @Binding var image:Image?
    @Binding var isPicking:Bool
    
    // UIViewControllerRepresentableプロトコルに宣言されているメソッド
    // UIKitフレームワークの中のUI部品（今回はUIImagePickerController）の調整役となるインスタンスを作るためのメソッド
    // その調整役がCoordinatorクラス
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        // UIImagePickerControllerというUIKitフレームワークのUI部品をインスタンス化
        let picker = UIImagePickerController()
        // 画像の取得方法をカメラ
        picker.sourceType = .camera
        // delegateとは直訳すると代理人という意味
        // あるクラスだけでは処理できない命令を、そのクラスの代わりに行うクラスのことをデリゲートと呼ぶ
        // 全てのクラスが別のクラスのデリゲートになれる
        // cordinatorプロパティにはmakeCoordinatorで返したインスタンスが格納されている
        // UIImagePickerControllerのdelegateプロパティは
        // (UIImagePickerControllerDelegate & UINavigationControllerDelegate)?プロトコルが宣言されている
        // Coordinatorクラスにはこの2つのプロトコルを批准させた
        // delegateプロパティにCoordinatorクラスのインスタンスを代入すると、CoordinatorクラスのインスタンスがUIImagePickerControllerクラスの代理人になる
        // UIImagePickerControllerDelegateプロトコルに宣言されているメソッドを実装すると、カメラアプリは「ユーザーが撮影した画像」を引数としてiOSから受け取ることが出来る。また、撮影画面でキャンセルをタップしたタイミングをiOS側から受け取ることが出来る。 -> Coordinatorクラスに両方ともプロトコルで必要であるため、実装済み
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
}

// イニシャライザ
struct ImagePicker_Previews: PreviewProvider {
    static var previews: some View {
        // Bindingにnilとtrueを渡している
        // Binding型の定数を作れる
        ImagePicker(image: .constant(nil), isPicking: .constant(true))
    }
}
