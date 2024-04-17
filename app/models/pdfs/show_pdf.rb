class ShowPdf < Prawn::Document
  def initialize(record) # ←ここでインスタンス(@records)の値を受け取る
    super(page_size: "A4") #A4サイズのPDFを新規作成
    # stroke_axis # 座標を表示
    @record = record # ←受け取った値をインスタンス変数として定義する。

    font_families.update("JP" => {
                          normal: "app/assets/fonts/ipaexm.ttf",
                          bold: "app/assets/fonts/ipaexg.ttf",
                        })
    font "JP"

    font_size 12

    stroke_color "000000"
    # タイトル
    move_down 30
    text "染め直し", align: :center, size: 20, style: :bold
    text "注文書・請求書", align: :center, size: 20, style: :bold

    # 宛名
    move_down 40
    if @record.customer.name.present?
      text_box "#{@record.customer.name}", at: [110, 660], size: 16, style: :bold
      text_box "様", at: [250, 660], size: 16, style: :bold
    else
      text "様", size: 16, style: :bold, align: :center
    end
    stroke_horizontal_line 40, 270, at: 640

    # 住所と電話番号
    move_down 20
    if @record.customer.address.present? && @record.customer.address.length > 25
      text_box "住所: #{@record.customer.address}", at: [40, 630], size: 12
      stroke_horizontal_line 40, 480, at: 615
    elsif @record.customer.address.present?
      text_box "住所: #{@record.customer.address}", at: [150, 630], size: 12
    else
      text_box "住所:", at: [150, 630], size: 12
    end
    stroke_horizontal_line 150, 480, at: 615
    move_down 10
    if @record.customer.address.present?
      text_box "電話番号: #{@record.customer.phonenumber}", at: [280, 600], size: 12
    else
      text_box "電話番号:", at: [280, 600], size: 12
    end
    stroke_horizontal_line 280, 480, at: 585

    # 商品欄
    move_down 60
    data = [["依頼品", "No.", "金額(税込)", "メモ欄"]]

    total_price = 0
    @record.items.each do |item|
      total_price
      data << [item.category.name, "", "#{item.price.to_s(:delimited)}円", ""]
      total_price = item.price + total_price
    end

    empty_rows = 10 - data.size
    empty_rows.times { data << ["", "", "", ""] }

    data << ["合計", "", "#{total_price.to_s(:delimited)}円", ""]

    table(data, column_widths: [260, 50, 80, 50], position: :center) do
      row(0).height = 35
      self.header = true # 最初の行をヘッダー行として設定
      row(0).font_style = :bold
      row(0).align = :center
      row(0).valign = :center
      rows(1..-1).height = 35
      cells.align = :center
      cells.valign = :center
      # rows(10..11).column(0).align = :right
    end

    # 会社情報
    move_down 40
    text "丸幸産業株式会社", size: 16, align: :center
    move_down 5
    text "登録番号: T2090001010145", align: :center
    text "〒403-0001 山梨県富士吉田市上暮地2222-1", align: :center
    text "☎ 0555-23-5562", align: :center
    text "Email: contact@marukousangyou.co.jp", align: :center
  end
end
