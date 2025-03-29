// https://lilithgames.feishu.cn/wiki/wikcnBdlB8AlekBdOX3TMORLbfg
//written by Maoshu YuXiang
//2024.4.25
//ver 2.02 给颜色图增加极坐标开关

Shader "UEP/Interface/DissolveStencil"
{
    Properties
    {
        [Toggle(UEP_VARIANT_1)] _Mask("_Mask(整体遮罩开关)", int) = 0
        [Toggle(UEP_VARIANT_2)]_Dissolve("_Dissolve(溶解算法开关)", int) = 0
        [Toggle(UEP_VARIANT_3)]_Direction("_Direction(溶解方向图开关)", int) = 0
        [Toggle(UEP_VARIANT_4)]_MainIsMask("_MainIsMask(使用主图做遮罩)", int) = 0
        [Toggle(UEP_VARIANT_5)]_StaticUV("_StaticUV(使用固定比例UV)", int) = 0
        _StaticUVScale("_StaticUVScale(固定比例UV大小)",range(0.0001,1)) = 0.05
        [Toggle]_StaticXZToggle("_StaticXZToggle(UI和场景切换)",Float) = 0
        [PerRendererData]_MainTex("_MainTex", 2D) = "white"{}
        _MainTex_ST("_MainTex_ST(主图ST)",vector) = (1,1,0,0)
        _NoiseTex("_NoiseTex(噪点图)", 2D) = "white"{}
        _MaskTex("_MaskTex(遮罩图)", 2D) = "white" {}
        _DirectionTex("_DirectionTex(溶解方向图)", 2D) = "black" {}

        _DissolveParam("_DissolveParam(溶解参数,x:溶解范围 y:噪点强度 z:边缘过渡 w:遮罩强度 )" , vector) = (5,1,0,0.5)
        _Param("_Param(x:溶解进度 y:旋转值 z:溶解宽度 w:裁剪范围)",vector) = (2,0,0.5,0.01)
        _NoisePower("_NoisePower",float) = 0

        [Header(Color)][Space]
        [Toggle(UEP_VARIANT_6)]_UseColorTex("_ColorTex(使用纹理图填充颜色)", int) = 0
        [Toggle]_ColorTexUsePolar("_ColorTexUsePolar(颜色纹理图开启极坐标效果)", int) = 0
        _ColorTex("_ColorTex(颜色纹理图)",2D) = "white"{}
        _ColorTex_Speed_X("_ColorTex_Speed_X(颜色纹理图X轴流动速度)",float) = 0
        _ColorTex_Speed_Y("_ColorTex_Speed_Y(颜色纹理图Y轴流动速度)",float) = 0
        [HDR]_EdgeColor("_EdgeColor(溶解颜色)", Color) = (1,0.3,0,1)

        [HideInInspector]_ColorMask("Color Mask", Float) = 15
        [Header(Setting)][Space]
        [KeywordEnum(AlphaBlend,Additive,AddEx)] _Blend("_Blend(叠加模式)", int) = 0
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _SrcBlend("SrcBlend", int) = 5
        [HideInInspector][Enum(UnityEngine.Rendering.BlendMode)] _DstBlend("DstBlend", int) = 10
             
        _Stencil("_Stencil", Float) = 3
        [Enum(UnityEngine.Rendering.StencilOp)]_StencilOp("_StencilOp",float) = 2 
        [Enum(UnityEngine.Rendering.CompareFunction)]_StencilComp("_StencilComp",float) = 8
        [HideInInspector]_StencilWriteMask("Stencil Write Mask", Float) = 255
        [HideInInspector]_StencilReadMask("Stencil Read Mask", Float) = 255

        [Header(Clip)]
        [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip("_UseUIAlphaClip", Float) = 0
        _AlphaClipThreshold("_AlphaClipThreshold", Float) = 0.001

        [Enum(UnityEngine.Rendering.CompareFunction)] _ZTest("ZTest(深度检测)", int) = 8
        [Toggle]_ZWrite("_ZWrite(深度)",int) = 0
		//[Enum(UnityEngine.Rendering.CullMode)] _Cull("Cull(剔除)", int) = 0
    }
    SubShader
    {
        Tags
        {
            "RenderType" = "Transparent"
            "Queue" = "Transparent"
            "PreviewType" = "Plane"
        }
        stencil
        {
            ref[_Stencil]
            Pass[_StencilOp]
            Comp[_StencilComp]
            ReadMask[_StencilReadMask]
            WriteMask[_StencilWriteMask]
        }

        Blend[_SrcBlend][_DstBlend]
        ZWrite [_ZWrite]
        Cull Off
        ZTest[_ZTest]
        ColorMask[_ColorMask]
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "UnityUI.cginc"

            #pragma shader_feature_local __ UEP_VARIANT_1		         // Mask
            #pragma shader_feature_local __ UEP_VARIANT_2		         // Dissolve
            #pragma shader_feature_local __ UEP_VARIANT_3		         // Direction
            #pragma shader_feature_local __ UEP_VARIANT_4		         // Main is Mask
            #pragma shader_feature_local __ UEP_VARIANT_5		         // WorldUV
            #pragma shader_feature_local __ UEP_VARIANT_6		         // ColorTex

            #pragma multi_compile __ UNITY_UI_ALPHACLIP                   // AlphaClip
            #pragma multi_compile __ UNITY_UI_CLIP_RECT                    // RectMask2D

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                float4 color : COLOR;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 uv : TEXCOORD0;
                float4 uv1 : TEXCOORD1;
                fixed4 color : COLOR;
            };

            sampler2D _MainTex,_NoiseTex,_MaskTex, _DirectionTex,_ColorTex;
            float4 _DissolveParam,_Param,_ColorTex_ST;
            fixed4 _NoiseTex_ST,_MaskTex_ST,_MainTex_ST, _DirectionTex_ST,_ClipRect;
            fixed _NoisePower,_AlphaClipThreshold, _StaticUVScale;
            float _ColorTex_Speed_X,_ColorTex_Speed_Y;
            int _ColorTexUsePolar,_StaticXZToggle;

            #define NOISE_WIDTH _DissolveParam.x
            #define NOIS_POWER _DissolveParam.y
            #define DISSOLVE_SOFT _DissolveParam.z
            #define MASK_POWER _DissolveParam.w

            #define DISSOLVE_VALUE _Param.x
            #define ROTATION _Param.y
            #define DISSOLVE_WIDTH _Param.z
            #define CLIP_RANGE _Param.w

            #ifdef UEP_VARIANT_2
                fixed4 _EdgeColor;
            #endif

            float2 Unity_Rotate_Radians_float(float2 UV , float Rotation)
            {
                //旋转uv算法
                half Center = half2(0.5,0.5);
                UV -= Center;
                float s = sin(Rotation);
                float c = cos(Rotation);
                float2x2 rMatrix = float2x2(c, -s, s, c);
                UV.xy = mul(UV.xy, rMatrix);
                UV += Center;
                return UV;

            }

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv.xy = v.uv;
                o.uv.zw = TRANSFORM_TEX(v.uv,_NoiseTex);
                o.uv1.xy = v.vertex;
                o.uv1.zw = v.vertex;
                #ifdef UEP_VARIANT_5
                    float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
                    float2 worldPos_uv = lerp( worldPos.xy , worldPos.xz, _StaticXZToggle);
                    o.uv1.zw = worldPos_uv * _StaticUVScale;
                #endif
                o.color = v.color;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
            #ifdef UNITY_UI_CLIP_RECT
                half out_alpha = UnityGet2DClipping(i.uv1.xy, _ClipRect);
                clip(out_alpha - 0.001);
                #endif

            #ifdef UEP_VARIANT_5
                float2 noise_uv = i.uv1.zw * _NoiseTex_ST.xy + _NoiseTex_ST.zw;
                float2 mask_uv = i.uv1.zw * _MaskTex_ST.xy + _MaskTex_ST.zw;
                float2 col_uv =  i.uv1.zw;
            #else
                float2 noise_uv = i.uv.zw;
                float2 mask_uv = i.uv.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
                float2 col_uv =  i.uv.xy;
            #endif

                fixed _DissolveCilp = 1;
                fixed noise_tex = tex2D(_NoiseTex , noise_uv).r * NOIS_POWER;
            #ifdef UEP_VARIANT_2
                float dissolve_uv = 0;
                fixed4 alpha_tex_main = tex2D(_MaskTex , mask_uv);
                float alpha_tex = alpha_tex_main.r * alpha_tex_main.a * MASK_POWER;
                #ifdef UEP_VARIANT_3
                    dissolve_uv = tex2D(_DirectionTex, i.uv.xy * _DirectionTex_ST.xy + _DirectionTex_ST.zw).r;
                #else        
                    dissolve_uv = Unity_Rotate_Radians_float(i.uv, ROTATION).x * NOISE_WIDTH;
                #endif  
                float dissolve_noise = dissolve_uv + noise_tex;
                fixed dissolve_front = smoothstep(DISSOLVE_VALUE , DISSOLVE_VALUE + DISSOLVE_SOFT , dissolve_noise + alpha_tex);
                fixed dissolve_back = smoothstep(DISSOLVE_VALUE + DISSOLVE_WIDTH, DISSOLVE_VALUE + DISSOLVE_WIDTH + DISSOLVE_SOFT, dissolve_noise - alpha_tex);
                _DissolveCilp = dissolve_front;
            #endif

            #ifdef UEP_VARIANT_1
                //Mask功能
                fixed4 alpha_tex_main2 = tex2D(_MainTex, i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw);
                fixed alpha_mask = alpha_tex_main2.r * alpha_tex_main2.a;
                half alpha_noise = (1 - step(alpha_mask * _NoisePower - noise_tex,alpha_mask));
                float alpha_noise2 = clamp(alpha_noise,alpha_mask,1);
                //fixed mask_alpha = step( CLIP_RANGE , alpha_tex_main2.r * alpha_tex_main2.a );
                half mask_alpha = step(CLIP_RANGE ,alpha_noise2);
                _DissolveCilp *= mask_alpha;
                #ifdef UEP_VARIANT_2
                dissolve_front = dissolve_front * mask_alpha;
                dissolve_back = dissolve_back * mask_alpha;
                #endif
                clip(_DissolveCilp - CLIP_RANGE);

            #endif

            fixed4 col = fixed4(0,0,0,0);

            #ifdef UEP_VARIANT_2
                fixed dissolve_mask = dissolve_front - dissolve_back;
                clip(_DissolveCilp - CLIP_RANGE);

                #ifdef UEP_VARIANT_6
                    if(_ColorTexUsePolar)
                    {
                        float2 delta = col_uv  - float2(0.5,0.5);
                        float radius = length(delta) * 2 * _ColorTex_ST.x + _ColorTex_Speed_X*_Time.y;
                        float angle = atan2(delta.x, delta.y) * 1.0/6.28 * _ColorTex_ST.y + _ColorTex_Speed_Y*_Time.y;
                        col_uv = float2(radius, angle);            
                    }
                    else
                    {
                        col_uv = col_uv * _ColorTex_ST.xy + _ColorTex_ST.zw +  float2(_ColorTex_Speed_X,_ColorTex_Speed_Y) * _Time.y;
                    }
                    half4 col_tex = tex2D(_ColorTex,col_uv);
                    col = col_tex * _EdgeColor * i.color;
                    col.a *= dissolve_mask;
                #else
                    col = _EdgeColor * i.color;
                    col.a *= dissolve_mask;
                #endif

                #ifdef UEP_VARIANT_4
                    half main_a = tex2D(_MainTex,i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw).a;
                    col.a *= main_a;
                #endif

                //UNITY_UI_ALPHACLIP可以删，有空检查一下
                #ifdef UNITY_UI_ALPHACLIP
                    clip(col.a - _AlphaClipThreshold);
                #endif
            #endif             

                return col;
            }
            ENDCG
        }
    }
        CustomEditor "ShaderEditorUniversal"
}
