// https://lilithgames.feishu.cn/wiki/wikcnfvzf1v8xVClJ3CtBAxWRNg
// ver 2.0 通用大版本迭代
//written by Maoshu
//2022.5.23
//UI Vignette Simple

Shader "UEP/Interface/VignetteSimple"
{
    Properties
    {
        BlackWidth ("BlackWidth" , Range(0,1) ) = 1
        [Toggle]_IsVertial("Vertial", int) = 0

		[Header(Setting)]
		[Toggle]_ZWrite("ZWrite", int) = 0
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

        //Stencil
        //{
        //    Ref 0
        //    Comp Always
        //    Pass Keep
        //}

        Lighting Off
        ZWrite [_ZWrite]
        ZTest [unity_GUIZTestMode]
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
			CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 2.0

            #include "UnityCG.cginc"

            struct appdata
            {
                half4 vertex   : POSITION;
                fixed4 color    : COLOR;
                float2 texcoord : TEXCOORD0;
            };

            struct v2f
            {
                half4 vertex   : SV_POSITION;
                float2 param  : TEXCOORD0;		
            };

            half BlackWidth;
            int _IsVertial;

            #define Vertex_alpha i.param.x
            #define UV i.param.y

            v2f vert(appdata v)
            {
                v2f o;
                float uv = _IsVertial == 1 ? v.texcoord.y : v.texcoord.x;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.param = float2(v.color.a,uv);

				return o;
            }

            float4 frag(v2f i) : SV_Target
            {
                float final = smoothstep(0,BlackWidth,UV);
                final *= Vertex_alpha;
                return float4(0,0,0, final);
            }
			ENDCG
        }
    }
    CustomEditor "ShaderHelpUniversal"
}
