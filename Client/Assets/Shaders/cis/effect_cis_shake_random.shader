// https://lilithgames.feishu.cn/wiki/wikcnmvvRumPuZP5hQ0e5HvWgZe
//written by Maoshu
//2022.7.15
//Random Shake UI

Shader "UEP/Interface/RandomShake"
{
    Properties
    {
        [HDR]_Color ("_Color(颜色)",color)= (1,1,1,1)
        [NonModifiableTextureData]_MainTex ("_MainTex_ST(主贴图TilingAndOffset)", 2D) = "white" {}
        _Speed ("_Speed(频率)", Float) = 1
        _Range ("_Range(幅度)",float) = 0.01
        _TimeOffset ("_TimeOffset(时间进度)",float) = 0

        [space(20)]
        [KeywordEnum(AlphaBlend,Additive,AddEx)]_Blend ("_Blend",int) = 0
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
		[HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10

    }
    SubShader
    {
        Tags 
        { 
            "Queue" = "Transparent" 
            "RenderType"="Transparent" 
            "CanUseSpriteAltas" = "True"
        }

        ZWrite Off
        ZTest Always
        Blend [_SrcBlend] [_DstBlend] 

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag


            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 color : Color;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float4 color : Color;
            };

            sampler2D _MainTex;
            half4 _Color,_MainTex_ST;
            half _Speed,_Range,_TimeOffset;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.color = v.color;
                return o;
            }


            half4 frag (v2f i) : SV_Target
            {
                if(i.color.a * _Color.a < 0.001)
                {
                    return 0;
                }
                half x = _Time.y * _Speed + _TimeOffset;
                half random_0 = sin(x) + x * 2;
                half random_1 = cos(random_0);
                half random_2 = sin(random_0);
                half random_x = sin(x * 4) * random_1 - random_2 * 0.5;
                half random_y = random_1 * random_2 + sin(random_2)*0.5;

                half4 col = tex2D(_MainTex,i.uv + float2(random_x,random_y) * _Range);
                col *= i.color * _Color;

                return col;
            }
            ENDCG
        }
    }
    CustomEditor "ShaderEditorUniversal"
}
