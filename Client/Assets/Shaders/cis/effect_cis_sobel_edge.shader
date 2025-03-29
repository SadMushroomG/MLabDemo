// https://lilithgames.feishu.cn/wiki/wikcnKUhOOuRjH5vEkM5I8NhlVb
// ver 2.0 通用迭代大版本
//written by YuXiang
//2022.04.13
//Sobel Edge

Shader "UEP/Interface/SobelEdge"
{
    Properties
    {
        [PerRendererData]_MainTex ("_MainTex(主图)" , 2D) = "white" {}
        //_MainTexParam ("_MainTexParam(x:主帖图溶解进度  y:主图溶解软边)" , Vector) = (0,0,0,0)
        _EdgeParam ("_EdgeParam(x: / y:/ z:/ w:边线阈值)",Vector) = (0,0,0,1)
		_EdgeColor2 ("Edge Color2", Color) = (1, 1, 1, 1)
		_BackgroundColor ("Background Color(描边图背景色)", Color) = (0, 0, 0, 0)
    }
    SubShader
    {
        Tags 
        {             
            "Queue"="Transparent"
            "IgnoreProjector"="True"
            "RenderType"="Transparent"
            "PreviewType"="Plane"
            "CanUseSpriteAtlas"="True"
        }

        ZWrite Off
        Blend One Zero

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                fixed4 vertex : POSITION;
                //fixed4 vertexColor : COLOR;
                fixed2 uv : TEXCOORD0;
               
            };

            struct v2f
            {
                fixed4 vertex : SV_POSITION;
                //fixed4 vertexColor : COLOR;
                fixed2 uv : TEXCOORD0;
                //fixed2 uvdissolve : TEXCOORD1;
                half2 uv2[9] : TEXCOORD2;
            };

            sampler2D _MainTex;
			//CBUFFER_START(UnityPerMaterial)
				fixed4 _MainTex_ST,_EdgeParam,_EdgeColor2,_BackgroundColor;
				//fixed2 _MainTexParam;
				uniform half4 _MainTex_TexelSize;
			//CBUFFER_END
           
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                //o.vertexColor = v.vertexColor;
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				half2 uv = v.uv;
				
				o.uv2[0] = uv + _MainTex_TexelSize.xy * half2(-1, -1);
				o.uv2[1] = uv + _MainTex_TexelSize.xy * half2(0, -1);
				o.uv2[2] = uv + _MainTex_TexelSize.xy * half2(1, -1);
				o.uv2[3] = uv + _MainTex_TexelSize.xy * half2(-1, 0);
				o.uv2[4] = uv + _MainTex_TexelSize.xy * half2(0, 0);
				o.uv2[5] = uv + _MainTex_TexelSize.xy * half2(1, 0);
				o.uv2[6] = uv + _MainTex_TexelSize.xy * half2(-1, 1);
				o.uv2[7] = uv + _MainTex_TexelSize.xy * half2(0, 1);
				o.uv2[8] = uv + _MainTex_TexelSize.xy * half2(1, 1);

                return o;
            }
            
            fixed luminance(fixed4 color) {
				return  0.2125 * color.r + 0.7154 * color.g + 0.0721 * color.b; 
			}
			
			half Sobel(v2f i) {
				const half Gx[9] = {-1,  0,  1,
										-2,  0,  2,
										-1,  0,  1};
				const half Gy[9] = {-1, -2, -1,
										0,  0,  0,
										1,  2,  1};		
				
				half texColor;
				half edgeX = 0;
				half edgeY = 0;
				for (int it = 0; it < 9; it++) {
					texColor = luminance(tex2D(_MainTex, i.uv2[it]));
					edgeX += texColor * Gx[it];
					edgeY += texColor * Gy[it];
				}
				
				half edge = 1 - abs(edgeX) - abs(edgeY);
				

				return abs(edgeX) + abs(edgeY);
			}

            fixed4 frag (v2f i) : SV_Target
            {

                half edge = Sobel(i);
                fixed4 maintex = tex2D(_MainTex, i.uv) ;
				fixed4 withEdgeColor = lerp(tex2D(_MainTex, i.uv2[4]), _EdgeColor2, edge);//edge比较小的地方采样出来几乎是edge—color
				fixed4 onlyEdgeColor = lerp(_BackgroundColor,_EdgeColor2 , edge);//edge比较小的地方采样出来几乎是edge-color
				fixed4 _EdgeImage = lerp(withEdgeColor, onlyEdgeColor,_EdgeParam.w);
                _EdgeImage.rgb *= _EdgeImage.a;
                
                return _EdgeImage;
            }
            ENDCG
        }
    }
	CustomEditor "ShaderHelpUniversal"
}
