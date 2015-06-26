<div class="container_12 product-item">
  <div class="grid_7">
    <div class="banner-big">
      <div class="banner-label"><h1>{$product->name|escape}</h1></div>
      <div class="big-image">
        <img src="{$product->image->filename|resize:640:640}" alt="{$product->name|escape}">
      </div>
    </div>
    <div class="description">
      {$product->annotation}
    </div>
    {foreach $product->variants as $v}
      {if $v@first}{$variant = $v}{/if}
    {/foreach}
    {if $product->variants|count > 0}
    {if $variant->price > 0}<div class="price">{$variant->price|convert} <span>{$currency->sign|escape}</span></div>{/if}
    {else}
    <p class="not-available">нет в наличии</p>
    {/if}
  </div>
  <div class="grid_5">
    <div class="right-block">
      <div class="form-title">
        <p class="big">Характеристики</p>
      </div>
      {if $product->features}
      <div id="tab-2" class="tab-content">
        <ul class="ul features">
          {foreach $product->features as $f}
          <li data-feature="{$f->id}">
            <span class="label">{$f->name}</span>
            <span class="value">{$f->value}</span>
          </li>
          {/foreach}
        </ul>
      </div>
      {/if}
    </div>
  </div>
  <div class="clear"></div>
  <div class="grid_12 product-action">
    <a href="#toOrder" class="button red makeCall" onclick="$('.input-product').val('{$product->name|escape}'); $('.input-price').val('{$variant->price|convert} {$currency->sign|escape}');"><i class="icon icon-order"></i>Заказать</a>
    <a href="#toConsult" class="button red makeCall" onclick="$('.input-product').val('{$product->name|escape}'); $('.input-price').val('{$variant->price|convert} {$currency->sign|escape}');"><i class="icon icon-consult"></i>Получить консультацию</a>
    <a href="http://shop-gsm.net/catalog/gsm-repeaters" target="_blank" onClick="_gaq.push(['_trackEvent', 'Кнопка в каталог с ПС', 'Нажатие',,, false]);" class="button big blue">Перейти в каталог</a>
  </div>
</div>