//https://lilithgames.feishu.cn/wiki/W7Quw4sx5ii46nkSxTScEcTWnkb
//written by Haidong
//2024.05.18
//IconOutlineDisplay

Shader "UEP/Interface/IconOutlineDisplay"
{
    Properties
    {
        [HideInInspector]_MainTex ("_MainTex(主贴图)", 2D) = "white" {} 
        _IconTex ("_IconTex(图像贴图)", 2D) = "white" {}
        _FlowTex ("_FlowTex（纹理贴图）", 2D) = "white" {}
        _SpeedX ("_SpeedX（X方向速度）", float) = 0
        _SpeedY("_SpeedY（Y方向速度）", float) = 0
        [HDR]_FlowCol("_FlowCol（纹理颜色）", Color) = (1,1,1,1)
        _RotationAngle("_RotationAngle（旋转角度）", Range(0, 360)) = 0
    }
    SubShader
    {
        Tags 
        {
            "Queue"="Transparent" 
            "IgnoreProjector"="True" 
            "RenderType"="Transparent"
        }

        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            Name "IconOutlineDisplay"
            ZWrite Off
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"


            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 uv : TEXCOORD0;
                
            };

            sampler2D _MainTex, _FlowTex ,_IconTex;
            fixed _FlowSpeed, _SpeedX, _SpeedY, _RotationAngle;
            fixed4  _FlowCol;
            fixed2 _FlowTex_ST;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                // UV 旋转
                float2 rotatedUV = v.uv.xy * _FlowTex_ST.xy - 0.5;
                fixed s = sin(_RotationAngle * 3.14159 / 180.0);
                fixed c = cos(_RotationAngle * 3.14159 / 180.0);
                float2 rotated = float2(
                    c * rotatedUV.x - s * rotatedUV.y,
                    s * rotatedUV.x + c * rotatedUV.y
                );
                rotatedUV = rotated + 0.5;
                o.uv.zw = rotatedUV + float2( _SpeedX * _Time.y , _SpeedY * _Time.y);
                o.uv.xy = v.uv.xy;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {

                fixed4 mask = tex2D(_MainTex, i.uv.xy);
                //clip(mask - 0.01);
                fixed4 flowCol = tex2D(_FlowTex, i.uv.zw) * _FlowCol * mask;
                fixed4 iconTex = tex2D(_IconTex, i.uv.xy);
                //ol = lerp(flowCol, col, col.a);
                //UITex.a = step(0.8,UITex.a);
                fixed4 final = lerp(flowCol, iconTex, iconTex.a);
                return final;
            }
            ENDCG
        }
    }
}