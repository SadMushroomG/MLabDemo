//https://lilithgames.feishu.cn/wiki/W7Quw4sx5ii46nkSxTScEcTWnkb
//written by Haidong
//2024.05.18
//IconOutlineBlur

Shader "UEP/Interface/IconOutlineBlur"
{
	Properties
    {
        [PerRendererData] _MainTex ("_MainTex(主贴图)", 2D) = "white" {}
        _BlurSize("_BlurSize(模糊范围)",Range(0,1)) = 0.01
        _SmoothStepX("_SmoothStepX（边缘值1）",float) = 0.01
        _SmoothStepY("_SmoothStepY（边缘值2）",float) = 0.1
    }
    SubShader
    {
        Tags
        { 
            "Queue"="Transparent" 
            "IgnoreProjector"="True" 
            "RenderType"="Transparent" 
            "PreviewType"="Plane"
        }
        
        Cull Off
        Lighting Off
        ZWrite Off
        Blend One Zero

        Pass
        {
            Name "IconOutlineBlur"
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex   : POSITION;
                fixed2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex   : SV_POSITION;
                fixed2 uv  : TEXCOORD0;
            };

            fixed4 _MainTex_ST;;
            sampler2D _MainTex;
            fixed _BlurSize, _SmoothStepX, _SmoothStepY;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            fixed4 SampleSpriteTexture (fixed2 uv)
            {
                fixed offset = _BlurSize * 0.0625f;

                // 左上
                fixed4 color = tex2D (_MainTex, fixed2(uv.x - offset,uv.y - offset)) * 0.0947416f;
                // 上
                color += tex2D(_MainTex,fixed2(uv.x,uv.y - offset)) * 0.118318f;
                // 右上
                color += tex2D(_MainTex,fixed2(uv.x + offset,uv.y + offset)) * 0.0947416f;
                // 左
                color += tex2D(_MainTex,fixed2(uv.x - offset,uv.y)) * 0.118318f;
                // 中
                color += tex2D(_MainTex,fixed2(uv.x,uv.y)) * 0.147761f;
                // 右
                color += tex2D(_MainTex,fixed2(uv.x + offset,uv.y)) * 0.118318f;
                // 左下
                color += tex2D (_MainTex, fixed2(uv.x - offset,uv.y + offset)) * 0.0947416f;
                // 下
                color += tex2D(_MainTex,fixed2(uv.x,uv.y + offset)) * 0.118318f;
                // 右下
                color += tex2D(_MainTex,fixed2(uv.x + offset,uv.y - offset)) * 0.0947416f;

                return color;
            }

            fixed4 frag(v2f i) : SV_Target
            {
               fixed4 c;
               c =  SampleSpriteTexture (i.uv ) ;
               c.rgb *= c.a;
               c = smoothstep(_SmoothStepX, _SmoothStepY,c.a);
               return c;
            }

            ENDCG

        }
    }
}
