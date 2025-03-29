// https://lilithgames.feishu.cn/wiki/wikcnCMbERmhy9dnmIjhpFK8l4d
//Ver 1.0 

Shader "UEP/Interface/CloudFlow"
{
    Properties
    {
        [Header(Main)] [Space(5)]
        _MainTime("_MainTime",float) = 1
        _MainTex ("_MainTex", 2D) = "white" {}
        _MainRotate("_MainRotate", float) = 0
        _MainSpeedX("_MainSpeedX",float) = 0
        _MainSpeedY("_MainSpeedY",float) = 0
        _CloudColor("_CloudColor",color) = (1,1,1,1)

        [Header(Noise)][Space(5)]
        _NoiseTex("_NoiseTex", 2D) = "black" {}
        _NoisePower("_NoisePower",float) = 0
        _CloudNoisePower("_CloudNoisePower",float) = 0

        [Header(Fog)][Space(5)]
        [Toggle(UEP_VARIANT_1)]_FogBlend("_FogBlend",float) = 1
        _FogColor("_FogColor",color) = (1,1,1,1)
        _FogOffset("_FogOffset",float) = 0
        _FogRange("_FogRange",float) = 1

        [Header(Mask)][Space(5)]
        _MaskTex("_MaskTex",2D) = "white"{}
        _MaskSpeedX("_MaskSpeedX",float) = 0
        _MaskSpeedY("_MaskSpeedY",float) = 0
        _MaskOffset("_MaskOffset",float) = -0.1


        [Header(Dissolve)][Space(5)]
        _DissolveTex("_DissolveTex",2D)="black"{}
        [Toggle]_DissolveRorA("_DissolveRorA",int)=0
        [Toggle]_DissolveOneMiuse("_DissolveOneMiuse",int)=0
        _DissolveRotate("_DissolveRotate",float)=0
        _DissolveValue("_DissolveValue",float) = 0.5

        [Header(Setting)][Space(5)]
        [KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend", int) = 0
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
        [Toggle]_ZWrite("_ZWrite", int) = 0 
        [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("_ZTest", int) = 0
        [Enum(UnityEngine.Rendering.CullMode)] _Cull("_Cull", int) = 2

        [Header(Clip)][Space(5)]
        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip("_UseUIAlphaClip", float) = 0
        _AlphaClipThreshold("_AlphaClipThreshold", range(0,1)) = 0.001

        [Header(Stencil)][Space(5)]
        _Stencil("_Stencil", Float) = 0
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp("_StencilComp", float) = 8
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilOp("_StencilOp", float) = 0
    }
    SubShader
    {
        Tags
        {
            "Queue" = "Transparent"
            "RenderType" = "Transparent"
            "PreviewType" = "Plane"
        }

        Stencil
        {
            Ref[_Stencil]
            Comp[_StencilComp]
            Pass[_StencilOp]
        }

        Cull [_Cull]
        ZWrite[_ZWrite]
        ZTest[_ZTest]
        Blend[_SrcBlend][_DstBlend]

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma multi_compile __ UNITY_UI_CLIP_RECT
            #pragma multi_compile __ UNITY_UI_ALPHACLIP
            #pragma shader_feature_local __ UEP_VARIANT_1					//���Ļ��ģʽ

            struct appdata
            {
                float4 vertex : POSITION;
                float4 uv : TEXCOORD0;
                half4 color : COLOR;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 uv : TEXCOORD0;
                half4 color : COLOR;
            };

            sampler2D _MainTex, _NoiseTex,_MaskTex,_DissolveTex;
            float4 _ClipRect, _MainTex_ST, _NoiseTex_ST, _MaskTex_ST, _DissolveTex_ST;
            half4 _CloudColor, _FogColor;
            float _MainRotate, _MainTime, _MainSpeedX, _MainSpeedY, _MaskSpeedX, _MaskSpeedY, _CloudNoisePower, _DissolveRotate;
            float  _DissolveValue, _FogOffset,_FogRange,_MaskOffset,_NoisePower;
            int _DissolveRorA, _DissolveOneMiuse,_AlphaClipThreshold;

            float2 Unity_Rotate_Radians_float(float2 UV, float Rotation)
            {
                UV -= 0.5;
                float s = sin(Rotation);
                float c = cos(Rotation);
                float2x2 rMatrix = float2x2(c, -s, s, c);
                UV.xy = mul(UV.xy, rMatrix);
                UV += 0.5;
                return UV;
            }

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.color = v.color;
                o.uv.xy = v.uv;
                o.uv.zw = v.vertex.xy;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
             #ifdef UNITY_UI_CLIP_RECT
                half out_alpha = UnityGet2DClipping(i.uv.zw, _ClipRect);
                clip(out_alpha - 0.001);
             #endif

                float2 texUV = i.uv.xy;
                float customTime = _Time.x * _MainTime;

                float2 noiseUV = texUV * _NoiseTex_ST.xy + _NoiseTex_ST.zw * customTime;
                float noise = (tex2D(_NoiseTex, noiseUV).r) * _NoisePower;

                float2 mainUV = Unity_Rotate_Radians_float(texUV,_MainRotate) * _MainTex_ST.xy + _MainTex_ST.zw + float2(_MainSpeedX, _MainSpeedY) * customTime + noise * _CloudNoisePower;
                half4 col = tex2D(_MainTex, mainUV) * _CloudColor;


                float2 maskUV = texUV * _MaskTex_ST.xy + _MaskTex_ST.zw + float2(_MaskSpeedX, _MaskSpeedY) * customTime ;
                float mask = tex2D(_MaskTex, maskUV).r;

                half fogmask = saturate(((1 - texUV.y) + _FogOffset) * _FogRange);
             #ifdef UEP_VARIANT_1
                col.xyz = lerp(col.xyz, _FogColor.xyz, fogmask * _FogColor.w);
             #else
                col.xyz = col.xyz +  _FogColor.xyz*fogmask * _FogColor.w;
             #endif
                

                col.a = step(noise, mask + _MaskOffset);

                if (_DissolveValue <0.95) 
                {
                    float2 dissolveUV = Unity_Rotate_Radians_float(texUV, _DissolveRotate) * _DissolveTex_ST.xy + _DissolveTex_ST.zw;
                    half4 dissolveTex = tex2D(_DissolveTex, dissolveUV);
                    dissolveTex = lerp(dissolveTex, (1 - dissolveTex), _DissolveOneMiuse);
                    half dissolve = lerp(dissolveTex.r, dissolveTex.a, _DissolveRorA);
                    col.a *= step(dissolve, _DissolveValue);
                }

             #ifdef UNITY_UI_ALPHACLIP
                clip(col.a - _AlphaClipThreshold);
             #endif

                return col * i.color;
            }
            ENDHLSL
        }
    }
       CustomEditor "ShaderEditorUniversal"
}
