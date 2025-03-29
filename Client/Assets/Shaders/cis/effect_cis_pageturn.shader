// https://lilithgames.feishu.cn/wiki/wikcnmSmaPlNiRIM7Ig0pIyN58c
// ver 2.1 Keyword调整
//written by Maoshu
//2022.2.24
//UI PageTurn Shader

Shader "UEP/Interface/PageTurn"
{
    Properties
    {
        [Toggle(UEP_VARIANT_1)] _Switch("_Switch(切换正面与反面)",int) = 0
        [PerRendererData]_MainTex("_MainTex(主贴图) _MainTex_ST(TillingAndOffset)", 2D) = "white" {}
        _Page("_Page(翻页程度)",float) = 0.5
        _ImageSizeX("_ImageSizeX(图片X尺寸)",float) = 512
        _ImageSizeY("_ImageSizeY(图片Y尺寸)",float) = 512
        _AngleX("_AngleX(翻页X轴角度)",float) = 1
        _AngleY("_AngleY(翻页Y轴角度)",float) = -0.5
        _ImageMax("_ImageMax(调整图片大小)",float) = 1.5

        [Space(20)]
        _Stencil("Stencil ID", Float) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp("Stencil Comparison", Float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilOp("Stencil Operation", Float) = 0
        [HideInInspector]_StencilWriteMask("Stencil Write Mask", Float) = 255
        [HideInInspector]_StencilReadMask("Stencil Read Mask", Float) = 255

    }
    SubShader
    {
        Tags 
        { 
            "Queue" = "Transparent" 
            "RenderType"="Transparent" 
            "IgnoreProjector" = "Ture"
            "CanUseSpriteAltas" = "False"
        }
        ZWrite Off
		ZTest Always
        Blend SrcAlpha OneMinusSrcAlpha

        Stencil
        {
            Ref[_Stencil]
            Comp[_StencilComp]
            Pass[_StencilOp]
            ReadMask[_StencilReadMask]
            WriteMask[_StencilWriteMask]
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

			#pragma shader_feature_local __ UEP_VARIANT_1					// _SwitchFrontAndBack 正反面开关

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 vertexColor : COLOR;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float4 color : Color;
            };

            sampler2D _MainTex;
			//CBUFFER_START(UnityPerMaterial)
				float4 _MainTex_ST;
				fixed _ImageSizeX;
				fixed _ImageSizeY;
				float _ImageMax;
				float _Page;
				fixed _AngleX;
				fixed _AngleY;
			//CBUFFER_END


            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.color = v.vertexColor;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                //调整图片比例
                float2 aspect = float2( _ImageSizeX / _ImageSizeY, 1.0 );
                float2 uv = i.uv;

				#ifdef UEP_VARIANT_1
                    float uvcenter = (_ImageMax - 1)/2;
                    uv = uv * _ImageMax - float2(uvcenter,uvcenter);
                #endif

                // Define the fold.
                float2 origin = float2(_Page , 1.0  ) * aspect;
                float2 normal = normalize(float2(_AngleX,_AngleY));

                float2 pt = uv * aspect - origin;
                float side = dot(pt, normal);

                clip(-side);

                float4 col = float4(0,0,0,0); 
                
                // Check on which side the pixel lies.
                
				#ifdef UEP_VARIANT_1
                    pt = (uv * aspect - 2.0 * side * normal) / aspect;
                    // Check if we're still inside the image bounds.
                    if (pt.x >= 0.0 && pt.x < 1.0 && pt.y >= 0.0 && pt.y < 1.0)
                    {
                        float4 back = tex2D(_MainTex, pt); // Back color.
                        back.rgb = back.rgb * 0.25 + 0.75;

                        float shadow = smoothstep(0.0, 0.2, -side);
                        back.rgb = lerp(back.rgb * 0.2, back.rgb, shadow);

                        // Support for transparency.
                        col.rgb = lerp(col.rgb, back.rgb, back.a);
                        col.a = back.a;
                    }
                #else
					// Sample texture.
					float4 texcol = tex2D( _MainTex, uv );
                    //back
                    col = texcol;
				#endif

                col *= i.color;
                return col;
            }
            ENDCG
        }
    }
	CustomEditor "ShaderHelpUniversal"
}
