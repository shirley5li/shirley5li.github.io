<div style="padding: 10px 0; margin: 20px auto; width: 90%; text-align: center;">
  <div>{{ theme.reward_comment }}</div>
  <button id="rewardButton" disable="enable" style="width: 80px;line-height: 38px;text-align: center;font-weight: bold;color: #fff;border-radius: 5px;
margin:0 20px 20px 0;position: relative;overflow: hidden;color: #8c96a0;text-shadow:1px 1px 1px #fff;border:1px solid #dce1e6;box-shadow: 0 1px 2px #fff inset,0 -1px 0 #a8abae inset;background: -webkit-linear-gradient(top,#f2f3f7,#e4e8ec);background: -moz-linear-gradient(top,#f2f3f7,#e4e8ec);background: linear-gradient(top,#f2f3f7,#e4e8ec);" onclick="var qr = document.getElementById('QR'); if (qr.style.display === 'none') {qr.style.display='block';} else {qr.style.display='none'}">
    打赏
  </button>
  <div id="QR" style="display: none; text-align: center;">

    {% if theme.wechatpay %}
      <div id="wechat" style="display: inline-block;">
        <img id="wechat_qr" src="{{ theme.wechatpay }}" alt="{{ theme.author }} WeChat Pay"/>
        <p>WeChat Pay</p>
      </div>
    {% endif %}

    {% if theme.alipay %}
      <div id="alipay" style="display: inline-block;">
        <img id="alipay_qr" src="{{ theme.alipay }}" alt="{{ theme.author }} Alipay"/>
        <p>Alipay</p>
      </div>
    {% endif %}

    {% if theme.bitcoin %}
      <div id="bitcoin" style="display: inline-block">
        <img id="bitcoin_qr" src="{{ theme.bitcoin }}" alt="{{ theme.author }} Bitcoin"/>
        <p>Bitcoin</p>
      </div>
    {% endif %}

  </div>
</div>
