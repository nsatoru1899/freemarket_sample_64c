module ItemsHelper
  def text_placeholder
    <<-"EOS".strip_heredoc
    商品の説明（必須 1,000文字以内）
    （色、素材、重さ、定価、注意点など）
    
    例）2010年ごろに１万円で購入したジャケットです。ライトグレーで傷はありません。あわせやすいのでおすすめです。
    EOS
  end
end
