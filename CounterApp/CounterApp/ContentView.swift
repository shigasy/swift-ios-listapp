//
//  ContentView.swift
//  CounterApp
//
//  Created by Keita Shiga on 2020/08/23.
//  Copyright © 2020 Keita Shiga. All rights reserved.
//

import SwiftUI

// プロパティには「インスタンスプロパティ」と「タイププロパティ」の2種類がある
// メソッドも同様
// インスタンスから呼び出すメソッドを「インスタンスメソッド」
// 構造体から直接呼び出すメソッドを「タイプメソッド」
// タイププロパティ、タイプメソッドは前にstaticをつける

// TODO: structでもタイププロパティで出来るんだが、enumとの違いを調べる

// タイププロパティとタイプメソッドはclass静的プロパティとclass静的メソッドみたいなもんじゃないかな。構造体版とclass版

struct ContentView: View {
    // @Stateキーワード そのプロパティの値が変更された時に、自動的にiPhoneの画面が更新される。
    // numberプロパティの変更による影響を受けない他のUI部品は再描画されないため、効率が良い。
    // @... をプロパティラッパーと呼ぶ
    // プロパティに特別な機能を追加する文法
    @State var number = 0
    var body: some View {
        // VStackのあとに()を書かないのはトレイリングクロージャによって()を省略しているから
        VStack {
            ZStack {
                Image("counter")
                    .resizable()
                    // contentModeはContentMode型がある
                    // enum型で宣言されており、.filと.fillの2つ以外は受け付けない
                    // このように決まりきった値のいずれかを必ず指定してほしいような場合、列挙型を使うことが有効。
                    // 上手に活用すればアプリがクラッシュするという不具合を事前に回避可能
                    .aspectRatio(contentMode: .fit)
                Text("\(number)")
                    // fontの引数はstatic let largeTitle: Fonr
                    // タイププロパティ
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/).font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            }
            
            // 短いクロージャの書き方
            Button(action: {self.number += 1}) {
                
                // 本来の無名関数（クロージャ）の書き方
                //            Button(action: {() -> Void in self.number += 1}) {
                Text("カウント")
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/).foregroundColor(.red).background(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/).cornerRadius(10.0)
            }
            
            // 末尾がクロージャの場合、省略できる（トレイリングクロージャ）。しない場合は
            // ドキュメントを見ると init(action: () -> Void, label: () -> Label) と書いてある
            Button(action: {self.number += 1}, label: {Text("カウント")
                .background(Color.red)})
            
            
            //            func count() {
            //                self.number += 1
            //            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
