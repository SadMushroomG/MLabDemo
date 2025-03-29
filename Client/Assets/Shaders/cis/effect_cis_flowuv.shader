// https://lilithgames.feishu.cn/wiki/wikcnP8Xu97zr73xnenrZomNUqd
// ver 2.0 通用大版本迭代
//written by Maoshu
//2022.6.29
//UI Special Path Flow Shader

Shader "UEP/Interface/FlowUV"
{
    Properties
    {
        [PerRendererData]_MainTex("_MainTex",2D)="white"{}
        _UVTex("_UVTex",2D) = "white"{}
        _SpeedX("SpeedX",float) = 0
        _SpeedY("SpeedY",float) = 0
        _NoisePower("_NoisePower",range(0,2)) = 0.05

        [Space(20)]
        [Enum(One,1,SrcAlpha,5)] _SrcBlend ("_SrcBlend(混合模式SrcBlend)", Float) = 5
        [Enum(One,1,OneMinusSrcAlpha,10)] _DstBlend ("_DstBlend(混合模式DstBlend)", Float) = 10

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
                fixed4 vertex : POSITION;
                fixed4 vertexColor : COLOR;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                fixed4 vertex : SV_POSITION;
                fixed4 vertexColor : COLOR;
            };

            sampler2D _MainTex,_UVTex;
			//CBUFFER_START(UnityPerMaterial)
				fixed4 _MainTex_ST,_UVTex_ST;
				fixed _NoisePower,_SpeedX,_SpeedY;
			//CBUFFER_END

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.vertexColor = v.vertexColor;
                o.uv = v.uv;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float4 flow_tex = tex2D( _UVTex , i.uv );

                if( i.vertexColor.w * flow_tex.a < 0.001)
                {
                    return 0;
                }

                float flow_uv_r = flow_tex.r * _UVTex_ST.x + _UVTex_ST.z + _SpeedX * _Time.y;
                float flow_uv_g = flow_tex.g * _UVTex_ST.y + _UVTex_ST.w + _SpeedY * _Time.y + (flow_tex.b-0.3) * _NoisePower;
                fixed4 color = tex2D( _MainTex , float2( flow_uv_r , flow_uv_g )) * i.vertexColor * flow_tex.a;

                //if( _DstBlend == 1)
                //{
                //    color .rgb *= i.vertexColor.a * color.a;
                //}
                return color;
            }
            ENDCG
        }
    }
	CustomEditor "ShaderHelpUniversal"
}
