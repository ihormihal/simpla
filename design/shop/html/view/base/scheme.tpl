<div class="hidden" xmlns:v="http://rdf.data-vocabulary.org/#" typeof="v:Organization">
    <span property="v:name" content="SHOP-GSM.NET"></span>
    {foreach $places as $place}
    {if $place->address}
    <div rel="v:address">
        <div typeof="v:Address">
            <span property="v:street-address" content="{$place->city}, {$place->address}"></span>
        </div>
    </div>
    {/if}
    {if $place->lat}
    <div rel="v:geo">
      <span typeof="v:Geo">
         <span property="v:latitude" content="{$place->lat}"></span>
         <span property="v:longitude" content="{$place->lng}"></span>
      </span>
    </div>
    {/if}
    {foreach $place->phones as $p}
    	<span property="v:tel" content="+38 {$p['code']} {$p['number']}"></span>
	{/foreach}
    {/foreach}
</div>

<div class="hidden vcard" style="position: absolute; left: -9999px; top: 0;">
    <div class="fn org">SHOP-GSM.NET</div>
    {foreach $places as $place}
    {if $place->address}
    <div class="adr">
        <span class="street-address">{$place->address}</span>
        <span class="locality">{$place->city}</span>
        <span class="country-name">Украина</span>
    </div>
    {/if}
    {foreach $place->phones as $phone}
    <div class="tel">
    	<span class="type">
    		{if $phone['code'] == '(066)' || $phone['code'] == '(095)'}
    		МТС
    		{else if $phone['code'] == '(067)'}
    		Киевстар
    		{else}
    		По городу
    		{/if}
    	</span>
        <span class="value">{$phone['code']}{$phone['number']}</span>
    </div>
    {/foreach}
    {/foreach}
</div>