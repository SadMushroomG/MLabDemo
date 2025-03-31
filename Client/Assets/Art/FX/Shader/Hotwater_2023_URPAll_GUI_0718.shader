// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hotwater/2023/URPAll_GUI_0718"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[Enum(blend,10,add,1)]_Float1("材质模式", Float) = 10
		[Enum(UnityEngine.Rendering.CullMode)]_Float2("双面模式", Float) = 0
		[Toggle]_Float4("深度写入", Float) = 0
		[Enum(UnityEngine.Rendering.CompareFunction)]_Ztestmode("深度测试", Float) = 4
		[Enum(UnityEngine.Rendering.ColorWriteMask)]_Float60("colormask", Float) = 15
		[Enum(UnityEngine.Rendering.CompareFunction)]_Ztestmode1("stencil_comp", Float) = 0
		[Enum(UnityEngine.Rendering.StencilOp)]_Ztestmode2("stencil_pass", Float) = 0
		_Float46("stencil_reference", Float) = 0
		[Toggle]_Float131("启用2u(需关闭customdata)", Float) = 0
		[Main(g10)]_Color_Group2("颜色", Float) = 0
		[HDR][Sub(g10)]_Color0("颜色", Color) = (1,1,1,1)
		[Sub(g10)]_Float14("整体颜色强度", Float) = 1
		[SubToggle(g10, _)]_Float35("双面颜色（默认关闭，勾上开启）", Float) = 0
		[HDR][Sub(g10)]_Color3("颜色2", Color) = (1,1,1,1)
		[Sub(g10)]_Float15("alpha强度", Float) = 1
		[SubToggle(g10, _)]_Float70("限制alpha值为0-1", Float) = 0
		[Main(g9)]_Depthfade_Group1("Depthfade", Float) = 0
		[Sub(g9)]_Float16("软粒子（羽化边缘）", Float) = 0
		[SubToggle(g9, _)]_Float5("反向软粒子(强化边缘）", Float) = 0
		[Sub(g9)]_Float28("边缘强度", Float) = 1
		[Sub(g9)]_Float30("边缘收窄", Float) = 1
		[Sub(g9)]_Float55("相机软粒子（贴脸羽化）距离", Float) = 0
		[Sub(g9)]_Float0("相机软粒子（贴脸羽化）位置", Float) = 0
		[Main(g8)]_Fresnel_Group2("菲尼尔", Float) = 0
		[SubToggle(g8, _)]_Float33("单独菲尼尔开关", Float) = 0
		[SubToggle(g8, _)]_Float145("双色菲尼尔", Float) = 0
		[Sub(g8)]_power3("菲尼尔范围", Float) = 1
		[HDR][Sub(g8)]_Color6("菲尼尔颜色", Color) = (1,1,1,1)
		[Sub(g8)]_Float19("菲尼尔软硬", Float) = 1
		[SubToggle(g8, _)]_Float20("反向菲尼尔（虚化边缘）", Float) = 0
		[Main(g1)]_Maintex_Group("主贴图", Float) = 0
		[SubToggle(g1, _)]_Float144("使用屏幕uv", Float) = 0
		[Sub(g1)]_maintex("主贴图", 2D) = "white" {}
		[SubToggle(g1, _)]_maintex_alpha("主贴图通道切换（默认A，勾上R）", Float) = 0
		[SubToggle(g1, _)]_Float62("主贴图x轴clamp", Float) = 0
		[SubToggle(g1, _)]_Float71("主贴图y轴clamp", Float) = 0
		[SubToggle(g1, _)]_Float49("主贴图极坐标（竖向贴图）", Float) = 0
		[Sub(g1)]_Float39("主贴图旋转", Range( -1 , 1)) = 0
		[HideInInspector]_maintex_ST("主贴图tilling&offset", Vector) = (1,1,0,0)
		[Sub(g1)]_Float34("主贴图细节对比度", Float) = 1
		[Sub(g1)]_Float37("主贴图细节提亮", Float) = 1
		[Sub(g1)]_Float36("细节平滑过渡", Range( 0 , 1)) = 1
		[Sub(g1)]_Vector0("主贴图流动&斜切", Vector) = (0,0,0,0)
		[Main(g11)]_Maintex_Group1("颜色混合", Float) = 0
		[Ramp(g11)]_Gradienttex("混合颜色贴图", 2D) = "white" {}
		[SubToggle(g11, _)]_Float63("颜色混合贴图x轴Clamp", Float) = 0
		[SubToggle(g11, _)]_Float81("颜色混合贴图y轴Clamp", Float) = 0
		[SubToggle(g11, _)]_Float50("颜色混合图极坐标（竖向贴图）", Float) = 0
		[Sub(g11)]_Float40("颜色混合贴图旋转", Range( -1 , 1)) = 0
		[Sub(g11)]_Vector9("颜色混合图tilling&offset", Vector) = (1,1,0,0)
		[Sub(g11)]_Vector7("颜色图流动速度", Vector) = (0,0,0,0)
		[SubToggle(g11, _)]_Float61("切换混合模式（默认lerp，勾上multiply）", Float) = 0
		[Sub(g11)]_Float29("颜色混合（lerp模式）", Range( 0 , 1)) = 0
		[Main(g2)]_Mask_Group("遮罩", Float) = 0
		[Sub(g2)]_Mask("遮罩01", 2D) = "white" {}
		[SubToggle(g2, _)]_mask01_alpha("遮罩01通道切换（默认A，勾上R）", Float) = 0
		[SubToggle(g2, _)]_Float64("遮罩01x轴Clamp", Float) = 0
		[SubToggle(g2, _)]_Float82("遮罩01y轴Clamp", Float) = 0
		[SubToggle(g2, _)]_Float51("遮罩01极坐标（竖向贴图）", Float) = 0
		[Sub(g2)]_Float43("遮罩01旋转", Range( -1 , 1)) = 0
		[HideInInspector]_Mask_ST("_Mask_ST", Vector) = (1,1,0,0)
		[Sub(g2)]_Vector11("遮罩01流动速度&斜切", Vector) = (0,0,0,0)
		[Sub(g2)]_Mask1("遮罩02", 2D) = "white" {}
		[SubToggle(g2, _)]_mask02_alpha("遮罩02通道切换（默认A，勾上R）", Float) = 0
		[SubToggle(g2, _)]_Float65("遮罩02x轴Clamp", Float) = 0
		[SubToggle(g2, _)]_Float83("遮罩02y轴Clamp", Float) = 0
		[SubToggle(g2, _)]_Float52("遮罩02极坐标（竖向贴图）", Float) = 0
		[Sub(g2)]_Float42("遮罩02旋转", Range( -1 , 1)) = 0
		[HideInInspector]_Mask1_ST("_Mask1_ST", Vector) = (1,1,0,0)
		[Sub(g2)]_Vector13("遮罩02流动&斜切", Vector) = (0,0,0,0)
		[Main(g3)]_Disolove_Group("溶解", Float) = 0
		[Sub(g3)]_dissolvetex("溶解贴图", 2D) = "white" {}
		[SubToggle(g3, _)]_Float66("溶解贴图x轴Clamp", Float) = 0
		[SubToggle(g3, _)]_Float87("溶解贴图y轴Clamp", Float) = 0
		[SubToggle(g3, _)]_Float53("溶解极坐标（竖向贴图）", Float) = 0
		[Sub(g3)]_Float41("溶解贴图旋转", Range( -1 , 1)) = 0
		[HideInInspector]_dissolvetex_ST("_dissolvetex_ST", Vector) = (1,1,0,0)
		[Sub(g3)]_Vector15("溶解流动&斜切", Vector) = (0,0,0,0)
		[Ramp(g3)]_TextureSample0("溶解方向贴图（渐变）", 2D) = "white" {}
		[Sub(g3)]_Float47("溶解方向旋转", Range( -1 , 1)) = 0
		[Sub(g3)]_Float130("混合溶解强度", Range( 0 , 1)) = 0
		[Sub(g3)]_Float6("溶解", Float) = 0
		[Sub(g3)]_Float8("软硬", Range( 0 , 0.5)) = 0.5
		[SubToggle(g3, _)]_Float25("亮边溶解（默认关闭，勾上开启）", Float) = 0
		[Sub(g3)]_Float17("亮边宽度", Range( 0 , 0.1)) = 0
		[HDR][Sub(g3)]_Color1("亮边颜色", Color) = (1,1,1,1)
		[SubToggle(g3, _)]_Float139("开洞（开启后方向失效）", Float) = 0
		[Sub(g3)]_Vector35("开洞坐标", Vector) = (0,0,0,0)
		[Sub(g3)]_Float72("alphaclip溶解（层级2000以下使用）", Float) = 0
		[Main(g4)]_Noise_Group("扰动", Float) = 0
		[SubToggle(g4, _)]_Float76("扰动遮罩/双重扰动（勾上启用双重扰动）", Float) = 0
		[Sub(g4)]_noise("扰动贴图", 2D) = "white" {}
		[SubToggle(g4, _)]_Float67("扰动贴图x轴Clamp", Float) = 0
		[SubToggle(g4, _)]_Float85("扰动贴图y轴Clamp", Float) = 0
		[SubToggle(g4, _)]_Float54("扰动极坐标（竖向贴图）", Float) = 0
		[Sub(g4)]_Float44("扰动贴图旋转", Range( -1 , 1)) = 0
		[HideInInspector]_noise_ST("_noise_ST", Vector) = (1,1,0,0)
		[Sub(g4)]_Vector17("扰动流动&斜切", Vector) = (0,0,0,0)
		[Sub(g4)]_noisemask("扰动遮罩", 2D) = "white" {}
		[SubToggle(g4, _)]_Float73("扰动遮罩x轴Clamp", Float) = 0
		[SubToggle(g4, _)]_Float84("扰动遮罩y轴Clamp", Float) = 0
		[SubToggle(g4, _)]_Float57("扰动遮罩极坐标", Float) = 0
		[Sub(g4)]_Float74("扰动遮罩旋转", Range( -1 , 1)) = 0
		[HideInInspector]_noisemask_ST("_noisemask_ST", Vector) = (1,1,0,0)
		[Sub(g4)]_Vector23("扰动遮罩流动&斜切", Vector) = (0,0,0,0)
		[Sub(g4)]_Vector33("扰动贴图remap", Vector) = (0,1,0,1)
		[Sub(g4)]_Float9("主贴图扰动强度", Float) = 0
		[Sub(g4)]_Float80("mask扰动强度", Float) = 0
		[Sub(g4)]_Float79("溶解扰动强度", Float) = 0
		[Main(g14)]_Maintex_Group4("Flowmap", Float) = 0
		[Sub(g14)]_flowmaptex("flowmaptex", 2D) = "white" {}
		[Sub(g14)]_Float32("flowmap扰动", Range( 0 , 1)) = 0
		[Main(g5)]_Vertex_Group("顶点偏移", Float) = 0
		[SubToggle(g5, _)]_Float135("顶点法线", Float) = 1
		[Sub(g5)]_vertextex("顶点偏移贴图", 2D) = "white" {}
		[Sub(g5)]_Vector32("顶点偏移贴图remap", Vector) = (0,1,0,1)
		[SubToggle(g5, _)]_Float68("顶点偏移贴图x轴Clamp", Float) = 0
		[SubToggle(g5, _)]_Float89("顶点偏移贴图y轴Clamp", Float) = 0
		[SubToggle(g5, _)]_Float56("顶点偏移极坐标（竖向贴图）", Float) = 0
		[Sub(g5)]_Float45("顶点贴图旋转", Range( -1 , 1)) = 0
		[HideInInspector]_vertextex_ST("_vertextex_ST", Vector) = (1,1,0,0)
		[Sub(g5)]_Vector19("顶点偏移流动&斜切", Vector) = (0,0,0,0)
		[Sub(g5)]_Vector5("顶点偏移xyz强度", Vector) = (0,0,0,0)
		[Sub(g5)]_vertextex1("顶点偏移遮罩", 2D) = "white" {}
		[SubToggle(g5, _)]_Float78("顶点偏移遮罩x轴Clamp", Float) = 0
		[SubToggle(g5, _)]_Float88("顶点偏移遮罩y轴Clamp", Float) = 0
		[SubToggle(g5, _)]_Float75("顶点偏移遮罩极坐标", Float) = 0
		[Sub(g5)]_Float77("顶点遮罩旋转", Range( -1 , 1)) = 0
		[HideInInspector]_vertextex1_ST("_vertextex1_ST", Vector) = (1,1,0,0)
		[Sub(g5)]_Vector25("顶点偏移遮罩流动＆斜切", Vector) = (0,0,0,0)
		[SubToggle(g6, _)]_Float48("折射开关", Float) = 0
		[SubToggle(g6, _)]_Float69("折射贴图x轴Clamp", Float) = 0
		[SubToggle(g6, _)]_Float86("折射贴图y轴Clamp", Float) = 0
		[Main(g12)]_Maintex_Group2("假光照", Float) = 0
		[SubToggle(g12, _)]_Float134("假光照开关", Float) = 0
		[Sub(g12)]_normallight("法线", 2D) = "white" {}
		[Sub(g12)]_Vector10("法线流动&斜切", Vector) = (0,0,0,0)
		[Sub(g12)]_Float146("光照法线强度", Float) = 0
		[Sub(g12)]_Float133("阴影软硬", Range( 0.5 , 1)) = 0.5
		[Sub(g12)]_Float132("阴影范围", Float) = 0.5
		[HDR][Sub(g12)]_Color5("亮部颜色", Color) = (1,1,1,1)
		[HDR][Sub(g12)]_Color4("暗部颜色", Color) = (0.490566,0.490566,0.490566,1)
		[SubToggle(g12, _)]_Float137("切换为假点光（默认为平行光）", Float) = 0
		[Sub(g12)]_Vector34("假点光坐标", Vector) = (0,0,0,0)
		[Main(g13)]_Maintex_Group3("Matcap", Float) = 0
		[SubToggle(g13, _)]_Float141("matcap开关", Float) = 0
		[Sub(g13)]_matcap("matcap(没有主贴图的话改成黑色）", 2D) = "white" {}
		[Sub(g13)]_Float140("matcap强度", Float) = 0
		[Sub(g13)]_normal("法线", 2D) = "white" {}
		[Sub(g13)]_Vector12("法线流动&斜切", Vector) = (0,0,0,0)
		[Sub(g13)]_Float18("法线强度", Float) = 0
		[Main(g15)]_Maintex_Group5("视差", Float) = 0
		[SubToggle(g15, _)]_Float143("开启视差映射(mesh模式下使用）", Float) = 0
		[Sub(g15)]_parallax("视差贴图", 2D) = "white" {}
		[Sub(g15)]_Float38("视差缩放", Float) = 0
		[Sub(g15)]_refplane("refplane(0黑色下沉,1白色抬高)", Range( 0 , 1)) = 1
		[Main(g7)]_Custom_Group1("custom控制", Float) = 0
		[SubToggle(g7, _)]_Float10("custom1xy控制主贴图偏移", Float) = 0
		[SubToggle(g7, _)]_Float12("custom1zw控制mask01偏移", Float) = 0
		[SubToggle(g7, _)]_Float11("custom2x控制溶解", Float) = 0
		[SubToggle(g7, _)]_Float129("粒子alpha控制溶解（溶解拖尾使用）", Float) = 0
		[SubToggle(g7, _)]_Float31("custom2y控制flowmap扭曲", Float) = 0
		[SubToggle(g7, _)]_Float142("custom2z控制溶解软硬", Float) = 0
		[ASEEnd][SubToggle(g7, _)]_Float22("custom2w控制顶点偏移强度", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25
	}

	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Transparent" "Queue"="Transparent" }
		
		Cull [_Float2]
		AlphaToMask Off
		HLSLINCLUDE
		#pragma target 3.0

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}
		
		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS

		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }
			
			Blend SrcAlpha [_Float1], One OneMinusSrcAlpha
			ZWrite Off
			ZTest LEqual
			Offset 0 , 0
			ColorMask [_Float60]
			Stencil
			{
				Ref [_Float46]
				Comp [_Ztestmode1]
				Pass [_Ztestmode1]
				Fail Keep
				ZFail Keep
			}

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#define _RECEIVE_SHADOWS_OFF 1
			#define ASE_SRP_VERSION 999999
			#define REQUIRE_DEPTH_TEXTURE 1

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/UnityInstancing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#if ASE_SRP_VERSION <= 70108
			#define REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR
			#endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_FRAG_COLOR


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_tangent : TANGENT;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				#ifdef ASE_FOG
				float fogFactor : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _Vector23;
			float4 _Color5;
			float4 _Color4;
			float4 _Vector35;
			float4 _TextureSample0_ST;
			float4 _Vector17;
			float4 _Vector15;
			float4 _Color1;
			float4 _Color6;
			float4 _Vector19;
			float4 _vertextex_ST;
			float4 _Color3;
			float4 _Vector10;
			float4 _Color0;
			float4 _Vector25;
			float4 _vertextex1_ST;
			float4 _Vector9;
			float4 _Gradienttex_ST;
			float4 _Vector0;
			float4 _maintex_ST;
			float4 _Vector7;
			float4 _flowmaptex_ST;
			float4 _parallax_ST;
			float4 _Vector33;
			float4 _noisemask_ST;
			float4 _Vector32;
			float4 _normallight_ST;
			float4 _dissolvetex_ST;
			float4 _Vector34;
			float4 _Mask1_ST;
			float4 _Vector13;
			float4 _Mask_ST;
			float4 _Vector11;
			float4 _normal_ST;
			float4 _Vector12;
			float4 _noise_ST;
			float3 _Vector5;
			float _Float134;
			float _Float29;
			float _Float81;
			float _Float63;
			float _Float40;
			float _Float50;
			float _Float132;
			float _Float51;
			float _Float80;
			float _Float15;
			float _Float43;
			float _Float39;
			float _Float32;
			float _Float133;
			float _Float137;
			float _Float9;
			float _Float52;
			float _Float42;
			float _Float44;
			float _Float54;
			float _mask01_alpha;
			float _Float47;
			float _Float61;
			float _Float8;
			float _Float17;
			float _Float41;
			float _Float79;
			float _Float53;
			float _Float18;
			float _Float140;
			float _Float129;
			float _Float11;
			float _Float6;
			float _Float130;
			float _Float141;
			float _Float145;
			float _Float19;
			float _power3;
			float _Float14;
			float _Float35;
			float _maintex_alpha;
			float _Float34;
			float _Float146;
			float _Float36;
			float _Float33;
			float _Float37;
			float _Float131;
			float _Float57;
			float _Float83;
			float _Float69;
			float _Float142;
			float _Float86;
			float _Float89;
			float _Float68;
			float _Float64;
			float _Float88;
			float _Float25;
			float _Float135;
			float _Float48;
			float _Float70;
			float _Float1;
			float _Maintex_Group5;
			float _Float78;
			float _Maintex_Group;
			float _Float82;
			float _Float20;
			float _Float85;
			float _Float67;
			float _Float73;
			float _Float84;
			float _Float76;
			float _Float10;
			float _Float65;
			float _Float31;
			float _Float5;
			float _Float139;
			float _Float87;
			float _Float66;
			float _Float71;
			float _Float62;
			float _Float12;
			float _Float74;
			float _Maintex_Group4;
			float _Vertex_Group;
			float _Float22;
			float _Float75;
			float _Float77;
			float _Float28;
			float _Float55;
			float _Float0;
			float _Float45;
			float _Float16;
			float _Float144;
			float _Float49;
			float _Float38;
			float _refplane;
			float _Float143;
			float _mask02_alpha;
			float _Float30;
			float _Maintex_Group1;
			float _Float56;
			float _Float60;
			float _Ztestmode2;
			float _Custom_Group1;
			float _Disolove_Group;
			float _Mask_Group;
			float _Color_Group2;
			float _Depthfade_Group1;
			float _Fresnel_Group2;
			float _Noise_Group;
			float _Float4;
			float _Maintex_Group3;
			float _Maintex_Group2;
			float _Ztestmode1;
			float _Ztestmode;
			float _Float46;
			float _Float2;
			float _Float72;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _vertextex;
			sampler2D _vertextex1;
			uniform float4 _CameraDepthTexture_TexelSize;
			sampler2D _maintex;
			sampler2D _parallax;
			sampler1D _noisemask;
			sampler2D _noise;
			sampler2D _flowmaptex;
			sampler2D _Gradienttex;
			sampler2D _dissolvetex;
			sampler1D _TextureSample0;
			sampler2D _normallight;
			sampler2D _matcap;
			sampler2D _normal;
			sampler2D _Mask;
			sampler2D _Mask1;


			inline float2 POM( sampler2D heightMap, float2 uvs, float2 dx, float2 dy, float3 normalWorld, float3 viewWorld, float3 viewDirTan, int minSamples, int maxSamples, float parallax, float refPlane, float2 tilling, float2 curv, int index )
			{
				float3 result = 0;
				int stepIndex = 0;
				int numSteps = ( int )lerp( (float)maxSamples, (float)minSamples, saturate( dot( normalWorld, viewWorld ) ) );
				float layerHeight = 1.0 / numSteps;
				float2 plane = parallax * ( viewDirTan.xy / viewDirTan.z );
				uvs.xy += refPlane * plane;
				float2 deltaTex = -plane * layerHeight;
				float2 prevTexOffset = 0;
				float prevRayZ = 1.0f;
				float prevHeight = 0.0f;
				float2 currTexOffset = deltaTex;
				float currRayZ = 1.0f - layerHeight;
				float currHeight = 0.0f;
				float intersection = 0;
				float2 finalTexOffset = 0;
				while ( stepIndex < numSteps + 1 )
				{
				 	currHeight = tex2Dgrad( heightMap, uvs + currTexOffset, dx, dy ).r;
				 	if ( currHeight > currRayZ )
				 	{
				 	 	stepIndex = numSteps + 1;
				 	}
				 	else
				 	{
				 	 	stepIndex++;
				 	 	prevTexOffset = currTexOffset;
				 	 	prevRayZ = currRayZ;
				 	 	prevHeight = currHeight;
				 	 	currTexOffset += deltaTex;
				 	 	currRayZ -= layerHeight;
				 	}
				}
				int sectionSteps = 10;
				int sectionIndex = 0;
				float newZ = 0;
				float newHeight = 0;
				while ( sectionIndex < sectionSteps )
				{
				 	intersection = ( prevHeight - prevRayZ ) / ( prevHeight - currHeight + currRayZ - prevRayZ );
				 	finalTexOffset = prevTexOffset + intersection * deltaTex;
				 	newZ = prevRayZ - intersection * layerHeight;
				 	newHeight = tex2Dgrad( heightMap, uvs + finalTexOffset, dx, dy ).r;
				 	if ( newHeight > newZ )
				 	{
				 	 	currTexOffset = finalTexOffset;
				 	 	currHeight = newHeight;
				 	 	currRayZ = newZ;
				 	 	deltaTex = intersection * deltaTex;
				 	 	layerHeight = intersection * layerHeight;
				 	}
				 	else
				 	{
				 	 	prevTexOffset = finalTexOffset;
				 	 	prevHeight = newHeight;
				 	 	prevRayZ = newZ;
				 	 	deltaTex = ( 1 - intersection ) * deltaTex;
				 	 	layerHeight = ( 1 - intersection ) * layerHeight;
				 	}
				 	sectionIndex++;
				}
				return uvs.xy + finalTexOffset;
			}
			
			
			VertexOutput VertexFunction ( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 appendResult557 = (float2(_Vector19.x , _Vector19.y));
				float2 uv_vertextex = v.ase_texcoord.xy * _vertextex_ST.xy + _vertextex_ST.zw;
				float2 uv2_vertextex = v.ase_texcoord1 * _vertextex_ST.xy + _vertextex_ST.zw;
				float uv2930 = _Float131;
				float2 lerpResult949 = lerp( uv_vertextex , uv2_vertextex , uv2930);
				float3 appendResult895 = (float3(1.0 , _Vector19.z , 0.0));
				float3 appendResult897 = (float3(_Vector19.w , 1.0 , 0.0));
				float2 temp_output_898_0 = mul( float3( lerpResult949 ,  0.0 ), float3x3(appendResult895, appendResult897, float3(0,0,1)) ).xy;
				float2 appendResult546 = (float2(_vertextex_ST.z , _vertextex_ST.w));
				float2 CenteredUV15_g100 = ( v.ase_texcoord.xy - float2( 0.5,0.5 ) );
				float2 break17_g100 = CenteredUV15_g100;
				float2 appendResult23_g100 = (float2(( length( CenteredUV15_g100 ) * _vertextex_ST.x * 2.0 ) , ( atan2( break17_g100.x , break17_g100.y ) * ( 1.0 / TWO_PI ) * _vertextex_ST.y )));
				float2 lerpResult556 = lerp( ( temp_output_898_0 + appendResult546 ) , (( appendResult23_g100 * temp_output_898_0 )*float2( 1,1 ) + appendResult546) , _Float56);
				float2 panner168 = ( 1.0 * _Time.y * appendResult557 + lerpResult556);
				float cos398 = cos( ( _Float45 * PI ) );
				float sin398 = sin( ( _Float45 * PI ) );
				float2 rotator398 = mul( panner168 - float2( 0.5,0.5 ) , float2x2( cos398 , -sin398 , sin398 , cos398 )) + float2( 0.5,0.5 );
				float2 break644 = rotator398;
				float clampResult646 = clamp( break644.x , 0.0 , 1.0 );
				float lerpResult790 = lerp( break644.x , clampResult646 , _Float68);
				float clampResult645 = clamp( break644.y , 0.0 , 1.0 );
				float lerpResult791 = lerp( break644.y , clampResult645 , _Float89);
				float2 appendResult647 = (float2(lerpResult790 , lerpResult791));
				float3 temp_cast_4 = (1.0).xxx;
				float3 lerpResult993 = lerp( temp_cast_4 , v.ase_normal , _Float135);
				float4 texCoord167 = v.ase_texcoord2;
				texCoord167.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult176 = lerp( 1.0 , texCoord167.w , _Float22);
				float2 appendResult719 = (float2(_Vector25.x , _Vector25.y));
				float2 uv_vertextex1 = v.ase_texcoord.xy * _vertextex1_ST.xy + _vertextex1_ST.zw;
				float2 uv2_vertextex1 = v.ase_texcoord1.xy * _vertextex1_ST.xy + _vertextex1_ST.zw;
				float2 lerpResult946 = lerp( uv_vertextex1 , uv2_vertextex1 , uv2930);
				float3 appendResult886 = (float3(1.0 , _Vector25.z , 0.0));
				float3 appendResult888 = (float3(_Vector25.w , 1.0 , 0.0));
				float2 appendResult710 = (float2(_vertextex1_ST.z , _vertextex1_ST.w));
				float2 CenteredUV15_g101 = ( v.ase_texcoord.xy - float2( 0.5,0.5 ) );
				float2 break17_g101 = CenteredUV15_g101;
				float2 appendResult23_g101 = (float2(( length( CenteredUV15_g101 ) * _vertextex1_ST.x * 2.0 ) , ( atan2( break17_g101.x , break17_g101.y ) * ( 1.0 / TWO_PI ) * _vertextex1_ST.y )));
				float2 lerpResult728 = lerp( ( mul( float3( lerpResult946 ,  0.0 ), float3x3(appendResult886, appendResult888, float3(0,0,1)) ).xy + appendResult710 ) , (mul( float3( appendResult23_g101 ,  0.0 ), float3x3(appendResult886, appendResult888, float3(0,0,1)) ).xy*float2( 1,1 ) + appendResult710) , _Float75);
				float2 panner725 = ( 1.0 * _Time.y * appendResult719 + lerpResult728);
				float cos726 = cos( ( _Float77 * PI ) );
				float sin726 = sin( ( _Float77 * PI ) );
				float2 rotator726 = mul( panner725 - float2( 0.5,0.5 ) , float2x2( cos726 , -sin726 , sin726 , cos726 )) + float2( 0.5,0.5 );
				float2 break720 = rotator726;
				float clampResult721 = clamp( break720.x , 0.0 , 1.0 );
				float lerpResult787 = lerp( break720.x , clampResult721 , _Float78);
				float clampResult722 = clamp( break720.y , 0.0 , 1.0 );
				float lerpResult789 = lerp( break720.y , clampResult722 , _Float88);
				float2 appendResult723 = (float2(lerpResult787 , lerpResult789));
				float3 vertexoffset181 = ( (_Vector32.z + (tex2Dlod( _vertextex, float4( appendResult647, 0, 0.0) ).r - _Vector32.x) * (_Vector32.w - _Vector32.z) / (_Vector32.y - _Vector32.x)) * lerpResult993 * _Vector5 * lerpResult176 * tex2Dlod( _vertextex1, float4( appendResult723, 0, 0.0) ).r );
				
				float3 customSurfaceDepth754 = v.vertex.xyz;
				float customEye754 = -TransformWorldToView(TransformObjectToWorld(customSurfaceDepth754)).z;
				o.ase_texcoord3.x = customEye754;
				float3 vertexPos97 = v.vertex.xyz;
				float4 ase_clipPos97 = TransformObjectToHClip((vertexPos97).xyz);
				float4 screenPos97 = ComputeScreenPos(ase_clipPos97);
				o.ase_texcoord4 = screenPos97;
				float4 ase_clipPos = TransformObjectToHClip((v.vertex).xyz);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord5 = screenPos;
				float3 ase_worldTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
				o.ase_texcoord7.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord8.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.ase_tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord9.xyz = ase_worldBitangent;
				
				o.ase_texcoord3.yz = v.ase_texcoord.xy;
				o.ase_texcoord6 = v.ase_texcoord1;
				o.ase_texcoord10 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.w = 0;
				o.ase_texcoord7.w = 0;
				o.ase_texcoord8.w = 0;
				o.ase_texcoord9.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = vertexoffset181;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );
				float4 positionCS = TransformWorldToHClip( positionWS );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				VertexPositionInputs vertexInput = (VertexPositionInputs)0;
				vertexInput.positionWS = positionWS;
				vertexInput.positionCS = positionCS;
				o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				#ifdef ASE_FOG
				o.fogFactor = ComputeFogFactor( positionCS.z );
				#endif
				o.clipPos = positionCS;
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_tangent : TANGENT;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_tangent = v.ase_tangent;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag ( VertexOutput IN , half ase_vface : VFACE ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif
				float customEye754 = IN.ase_texcoord3.x;
				float cameraDepthFade754 = (( customEye754 -_ProjectionParams.y - _Float0 ) / _Float55);
				float4 screenPos97 = IN.ase_texcoord4;
				float4 ase_screenPosNorm97 = screenPos97 / screenPos97.w;
				ase_screenPosNorm97.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm97.z : ase_screenPosNorm97.z * 0.5 + 0.5;
				float screenDepth97 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm97.xy ),_ZBufferParams);
				float distanceDepth97 = saturate( abs( ( screenDepth97 - LinearEyeDepth( ase_screenPosNorm97.z,_ZBufferParams ) ) / ( _Float16 ) ) );
				float depthfade_switch334 = _Float5;
				float lerpResult336 = lerp( distanceDepth97 , ( 1.0 - distanceDepth97 ) , depthfade_switch334);
				float depthfade126 = ( saturate( cameraDepthFade754 ) * lerpResult336 );
				float lerpResult330 = lerp( 0.0 , depthfade126 , depthfade_switch334);
				float2 appendResult440 = (float2(_Vector0.x , _Vector0.y));
				float2 uv_maintex = IN.ase_texcoord3.yz * _maintex_ST.xy + _maintex_ST.zw;
				float4 screenPos = IN.ase_texcoord5;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 appendResult1132 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1131 = (float2(_maintex_ST.x , _maintex_ST.y));
				float2 appendResult1130 = (float2(_maintex_ST.z , _maintex_ST.w));
				float2 lerpResult1127 = lerp( uv_maintex , (appendResult1132*appendResult1131 + appendResult1130) , _Float144);
				float3 appendResult799 = (float3(1.0 , _Vector0.z , 0.0));
				float3 appendResult803 = (float3(_Vector0.w , 1.0 , 0.0));
				float2 appendResult433 = (float2(_maintex_ST.z , _maintex_ST.w));
				float4 texCoord39 = IN.ase_texcoord6;
				texCoord39.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult42 = (float2(texCoord39.x , texCoord39.y));
				float2 lerpResult59 = lerp( appendResult433 , appendResult42 , _Float10);
				float2 CenteredUV15_g90 = ( IN.ase_texcoord3.yz - float2( 0.5,0.5 ) );
				float2 break17_g90 = CenteredUV15_g90;
				float2 appendResult23_g90 = (float2(( length( CenteredUV15_g90 ) * _maintex_ST.x * 2.0 ) , ( atan2( break17_g90.x , break17_g90.y ) * ( 1.0 / TWO_PI ) * _maintex_ST.y )));
				float2 lerpResult449 = lerp( appendResult433 , appendResult42 , _Float10);
				float2 lerpResult444 = lerp( ( mul( float3( lerpResult1127 ,  0.0 ), float3x3(appendResult799, appendResult803, float3(0,0,1)) ).xy + lerpResult59 ) , (mul( float3( appendResult23_g90 ,  0.0 ), float3x3(appendResult799, appendResult803, float3(0,0,1)) ).xy*float2( 1,1 ) + lerpResult449) , _Float49);
				float2 panner36 = ( 1.0 * _Time.y * appendResult440 + lerpResult444);
				float2 maintexUV_00161 = panner36;
				float3 ase_worldTangent = IN.ase_texcoord7.xyz;
				float3 ase_worldNormal = IN.ase_texcoord8.xyz;
				float3 ase_worldBitangent = IN.ase_texcoord9.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				ase_tanViewDir = normalize(ase_tanViewDir);
				float2 OffsetPOM1092 = POM( _parallax, maintexUV_00161, ddx(maintexUV_00161), ddy(maintexUV_00161), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, 128, 128, ( _Float38 * 0.1 ), _refplane, _parallax_ST.xy, float2(0,0), 0 );
				float2 parallax1097 = OffsetPOM1092;
				float2 lerpResult1099 = lerp( maintexUV_00161 , parallax1097 , _Float143);
				float2 appendResult687 = (float2(_Vector23.x , _Vector23.y));
				float2 uv_noisemask = IN.ase_texcoord3.yz * _noisemask_ST.xy + _noisemask_ST.zw;
				float2 uv2_noisemask = IN.ase_texcoord6.xy * _noisemask_ST.xy + _noisemask_ST.zw;
				float uv2930 = _Float131;
				float2 lerpResult938 = lerp( uv_noisemask , uv2_noisemask , uv2930);
				float3 appendResult866 = (float3(1.0 , _Vector23.z , 0.0));
				float3 appendResult865 = (float3(_Vector23.w , 1.0 , 0.0));
				float2 appendResult679 = (float2(_noisemask_ST.z , _noisemask_ST.w));
				float2 CenteredUV15_g47 = ( IN.ase_texcoord3.yz - float2( 0.5,0.5 ) );
				float2 break17_g47 = CenteredUV15_g47;
				float2 appendResult23_g47 = (float2(( length( CenteredUV15_g47 ) * _noisemask_ST.x * 2.0 ) , ( atan2( break17_g47.x , break17_g47.y ) * ( 1.0 / TWO_PI ) * _noisemask_ST.y )));
				float2 lerpResult688 = lerp( ( mul( float3( lerpResult938 ,  0.0 ), float3x3(appendResult866, appendResult865, float3(0,0,1)) ).xy + appendResult679 ) , (mul( float3( appendResult23_g47 ,  0.0 ), float3x3(appendResult866, appendResult865, float3(0,0,1)) ).xy*float2( 1,1 ) + appendResult679) , _Float57);
				float2 panner697 = ( 1.0 * _Time.y * appendResult687 + lerpResult688);
				float cos698 = cos( ( _Float74 * PI ) );
				float sin698 = sin( ( _Float74 * PI ) );
				float2 rotator698 = mul( panner697 - float2( 0.5,0.5 ) , float2x2( cos698 , -sin698 , sin698 , cos698 )) + float2( 0.5,0.5 );
				float2 break689 = rotator698;
				float clampResult690 = clamp( break689.x , 0.0 , 1.0 );
				float lerpResult775 = lerp( break689.x , clampResult690 , _Float73);
				float clampResult691 = clamp( break689.y , 0.0 , 1.0 );
				float lerpResult776 = lerp( break689.x , clampResult691 , _Float84);
				float2 appendResult693 = (float2(lerpResult775 , lerpResult776));
				float4 tex1DNode564 = tex1D( _noisemask, appendResult693.x );
				float2 appendResult530 = (float2(_Vector17.x , _Vector17.y));
				float2 uv_noise = IN.ase_texcoord3.yz * _noise_ST.xy + _noise_ST.zw;
				float2 uv2_noise = IN.ase_texcoord6.xy * _noise_ST.xy + _noise_ST.zw;
				float2 lerpResult941 = lerp( uv_noise , uv2_noise , uv2930);
				float3 appendResult876 = (float3(1.0 , _Vector17.z , 0.0));
				float3 appendResult878 = (float3(_Vector17.w , 1.0 , 0.0));
				float2 appendResult531 = (float2(_noise_ST.z , _noise_ST.w));
				float2 CenteredUV15_g46 = ( IN.ase_texcoord3.yz - float2( 0.5,0.5 ) );
				float2 break17_g46 = CenteredUV15_g46;
				float2 appendResult23_g46 = (float2(( length( CenteredUV15_g46 ) * _noise_ST.x * 2.0 ) , ( atan2( break17_g46.x , break17_g46.y ) * ( 1.0 / TWO_PI ) * _noise_ST.y )));
				float2 lerpResult539 = lerp( ( mul( float3( lerpResult941 ,  0.0 ), float3x3(appendResult876, appendResult878, float3(0,0,1)) ).xy + appendResult531 ) , (mul( float3( appendResult23_g46 ,  0.0 ), float3x3(appendResult876, appendResult878, float3(0,0,1)) ).xy*float2( 1,1 ) + appendResult531) , _Float54);
				float2 panner53 = ( 1.0 * _Time.y * appendResult530 + lerpResult539);
				float cos395 = cos( ( _Float44 * PI ) );
				float sin395 = sin( ( _Float44 * PI ) );
				float2 rotator395 = mul( panner53 - float2( 0.5,0.5 ) , float2x2( cos395 , -sin395 , sin395 , cos395 )) + float2( 0.5,0.5 );
				float2 break638 = rotator395;
				float clampResult640 = clamp( break638.x , 0.0 , 1.0 );
				float lerpResult778 = lerp( break638.x , clampResult640 , _Float67);
				float clampResult639 = clamp( break638.y , 0.0 , 1.0 );
				float lerpResult780 = lerp( break638.y , clampResult639 , _Float85);
				float2 appendResult641 = (float2(lerpResult778 , lerpResult780));
				float temp_output_923_0 = (_Vector33.z + (tex2D( _noise, appendResult641 ).r - _Vector33.x) * (_Vector33.w - _Vector33.z) / (_Vector33.y - _Vector33.x));
				float lerpResult701 = lerp( ( tex1DNode564.r * temp_output_923_0 ) , ( tex1DNode564.r + temp_output_923_0 ) , _Float76);
				float noise70 = lerpResult701;
				float noise_intensity_main67 = ( _Float9 * 0.1 );
				float2 uv_flowmaptex = IN.ase_texcoord3.yz * _flowmaptex_ST.xy + _flowmaptex_ST.zw;
				float4 tex2DNode241 = tex2D( _flowmaptex, uv_flowmaptex );
				float2 appendResult242 = (float2(tex2DNode241.r , tex2DNode241.g));
				float2 flowmap285 = appendResult242;
				float flowmap_intensity311 = _Float32;
				float4 texCoord100 = IN.ase_texcoord10;
				texCoord100.xy = IN.ase_texcoord10.xy * float2( 1,1 ) + float2( 0,0 );
				float flpwmap_custom_switch316 = _Float31;
				float lerpResult99 = lerp( flowmap_intensity311 , texCoord100.y , flpwmap_custom_switch316);
				float2 lerpResult283 = lerp( ( lerpResult1099 + ( noise70 * noise_intensity_main67 ) ) , flowmap285 , lerpResult99);
				float cos377 = cos( ( _Float39 * PI ) );
				float sin377 = sin( ( _Float39 * PI ) );
				float2 rotator377 = mul( lerpResult283 - float2( 0.5,0.5 ) , float2x2( cos377 , -sin377 , sin377 , cos377 )) + float2( 0.5,0.5 );
				float2 break603 = rotator377;
				float clampResult604 = clamp( break603.x , 0.0 , 1.0 );
				float lerpResult607 = lerp( break603.x , clampResult604 , _Float62);
				float clampResult605 = clamp( break603.y , 0.0 , 1.0 );
				float lerpResult764 = lerp( break603.y , clampResult605 , _Float71);
				float2 appendResult606 = (float2(lerpResult607 , lerpResult764));
				float4 tex2DNode1 = tex2D( _maintex, appendResult606 );
				float2 appendResult464 = (float2(_Vector7.x , _Vector7.y));
				float2 uv_Gradienttex = IN.ase_texcoord3.yz * _Gradienttex_ST.xy + _Gradienttex_ST.zw;
				float3 appendResult851 = (float3(1.0 , _Vector0.z , 0.0));
				float3 appendResult852 = (float3(_Vector0.w , 1.0 , 0.0));
				float2 temp_output_854_0 = mul( float3( uv_Gradienttex ,  0.0 ), float3x3(appendResult851, appendResult852, float3(0,0,1)) ).xy;
				float2 appendResult454 = (float2(( _Vector9.x - 1.0 ) , ( _Vector9.y - 1.0 )));
				float2 appendResult457 = (float2(_Vector9.z , _Vector9.w));
				float2 CenteredUV15_g92 = ( uv_Gradienttex - float2( 0.5,0.5 ) );
				float2 break17_g92 = CenteredUV15_g92;
				float2 appendResult23_g92 = (float2(( length( CenteredUV15_g92 ) * _Vector9.x * 2.0 ) , ( atan2( break17_g92.x , break17_g92.y ) * ( 1.0 / TWO_PI ) * _Vector9.y )));
				float2 lerpResult451 = lerp( (temp_output_854_0*appendResult454 + ( temp_output_854_0 + appendResult457 )) , (mul( float3( appendResult23_g92 ,  0.0 ), float3x3(appendResult851, appendResult852, float3(0,0,1)) ).xy*float2( 1,1 ) + appendResult457) , _Float50);
				float2 panner229 = ( 1.0 * _Time.y * appendResult464 + lerpResult451);
				float2 Gradienttex231 = panner229;
				float2 temp_cast_19 = (noise70).xx;
				float2 lerpResult235 = lerp( Gradienttex231 , temp_cast_19 , noise_intensity_main67);
				float cos383 = cos( ( _Float40 * PI ) );
				float sin383 = sin( ( _Float40 * PI ) );
				float2 rotator383 = mul( lerpResult235 - float2( 0.5,0.5 ) , float2x2( cos383 , -sin383 , sin383 , cos383 )) + float2( 0.5,0.5 );
				float2 break609 = rotator383;
				float clampResult610 = clamp( break609.x , 0.0 , 1.0 );
				float lerpResult765 = lerp( break609.x , clampResult610 , _Float63);
				float clampResult611 = clamp( break609.y , 0.0 , 1.0 );
				float lerpResult767 = lerp( break609.y , clampResult611 , _Float81);
				float2 appendResult768 = (float2(lerpResult765 , lerpResult767));
				float4 tex2DNode212 = tex2D( _Gradienttex, appendResult768 );
				float4 lerpResult211 = lerp( tex2DNode1 , tex2DNode212 , _Float29);
				float4 lerpResult600 = lerp( lerpResult211 , ( tex2DNode1 * tex2DNode212 ) , _Float61);
				float4 lerpResult359 = lerp( _Color0 , _Color3 , _Float35);
				float4 switchResult356 = (((ase_vface>0)?(_Color0):(lerpResult359)));
				ase_worldViewDir = SafeNormalize( ase_worldViewDir );
				float3 normalizedWorldNormal = normalize( ase_worldNormal );
				float fresnelNdotV139 = dot( normalize( ( normalizedWorldNormal * ase_vface ) ), ase_worldViewDir );
				float fresnelNode139 = ( 0.0 + _power3 * pow( max( 1.0 - fresnelNdotV139 , 0.0001 ), _Float19 ) );
				float temp_output_140_0 = saturate( fresnelNode139 );
				float lerpResult144 = lerp( temp_output_140_0 , ( 1.0 - temp_output_140_0 ) , _Float20);
				float fresnel147 = lerpResult144;
				float4 lerpResult1135 = lerp( switchResult356 , _Color6 , fresnel147);
				float4 lerpResult1145 = lerp( switchResult356 , lerpResult1135 , _Float145);
				float lerpResult347 = lerp( 1.0 , fresnel147 , _Float33);
				float4 texCoord49 = IN.ase_texcoord10;
				texCoord49.xy = IN.ase_texcoord10.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult62 = lerp( _Float6 , texCoord49.x , _Float11);
				float lerpResult913 = lerp( lerpResult62 , ( 1.0 - IN.ase_color.a ) , _Float129);
				float2 appendResult501 = (float2(_Vector15.x , _Vector15.y));
				float2 uv_dissolvetex = IN.ase_texcoord3.yz * _dissolvetex_ST.xy + _dissolvetex_ST.zw;
				float2 uv2_dissolvetex = IN.ase_texcoord6.xy * _dissolvetex_ST.xy + _dissolvetex_ST.zw;
				float2 lerpResult952 = lerp( uv_dissolvetex , uv2_dissolvetex , uv2930);
				float3 appendResult810 = (float3(1.0 , _Vector15.z , 0.0));
				float3 appendResult811 = (float3(_Vector15.w , 1.0 , 0.0));
				float2 appendResult502 = (float2(_dissolvetex_ST.z , _dissolvetex_ST.w));
				float2 CenteredUV15_g91 = ( IN.ase_texcoord3.yz - float2( 0.5,0.5 ) );
				float2 break17_g91 = CenteredUV15_g91;
				float2 appendResult23_g91 = (float2(( length( CenteredUV15_g91 ) * _dissolvetex_ST.x * 2.0 ) , ( atan2( break17_g91.x , break17_g91.y ) * ( 1.0 / TWO_PI ) * _dissolvetex_ST.y )));
				float2 lerpResult511 = lerp( ( mul( float3( lerpResult952 ,  0.0 ), float3x3(appendResult810, appendResult811, float3(0,0,1)) ).xy + appendResult502 ) , (mul( float3( appendResult23_g91 ,  0.0 ), float3x3(appendResult810, appendResult811, float3(0,0,1)) ).xy*float2( 1,1 ) + appendResult502) , _Float53);
				float2 panner58 = ( 1.0 * _Time.y * appendResult501 + lerpResult511);
				float noise_intensity_dis733 = ( _Float79 * 0.1 );
				float4 texCoord303 = IN.ase_texcoord10;
				texCoord303.xy = IN.ase_texcoord10.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult307 = lerp( flowmap_intensity311 , texCoord303.y , flpwmap_custom_switch316);
				float2 lerpResult309 = lerp( ( panner58 + ( noise70 * noise_intensity_dis733 ) ) , flowmap285 , lerpResult307);
				float2 dissolveUV92 = lerpResult309;
				float cos386 = cos( ( _Float41 * PI ) );
				float sin386 = sin( ( _Float41 * PI ) );
				float2 rotator386 = mul( dissolveUV92 - float2( 0.5,0.5 ) , float2x2( cos386 , -sin386 , sin386 , cos386 )) + float2( 0.5,0.5 );
				float2 break635 = rotator386;
				float clampResult632 = clamp( break635.x , 0.0 , 1.0 );
				float lerpResult784 = lerp( break635.x , clampResult632 , _Float66);
				float clampResult633 = clamp( break635.y , 0.0 , 1.0 );
				float lerpResult786 = lerp( break635.y , clampResult633 , _Float87);
				float2 appendResult631 = (float2(lerpResult784 , lerpResult786));
				float2 uv_TextureSample0 = IN.ase_texcoord3.yz * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
				float2 uv2_TextureSample0 = IN.ase_texcoord6.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
				float2 lerpResult955 = lerp( uv_TextureSample0 , uv2_TextureSample0 , uv2930);
				float2 CenteredUV15_g93 = ( lerpResult955 - float2( 0.5,0.5 ) );
				float2 break17_g93 = CenteredUV15_g93;
				float2 appendResult23_g93 = (float2(( length( CenteredUV15_g93 ) * 1.0 * 2.0 ) , ( atan2( break17_g93.x , break17_g93.y ) * ( 1.0 / TWO_PI ) * 1.0 )));
				float2 lerpResult568 = lerp( lerpResult955 , appendResult23_g93 , _Float53);
				float cos417 = cos( ( _Float47 * PI ) );
				float sin417 = sin( ( _Float47 * PI ) );
				float2 rotator417 = mul( lerpResult568 - float2( 0.5,0.5 ) , float2x2( cos417 , -sin417 , sin417 , cos417 )) + float2( 0.5,0.5 );
				float3 appendResult1017 = (float3(_Vector35.x , _Vector35.y , _Vector35.z));
				float lerpResult1057 = lerp( tex1D( _TextureSample0, rotator417.x ).r , distance( appendResult1017 , WorldPosition ) , _Float139);
				float dis_direction277 = lerpResult1057;
				float lerpResult1060 = lerp( _Float130 , ( 1.0 - _Float130 ) , _Float139);
				float lerpResult916 = lerp( tex2D( _dissolvetex, appendResult631 ).r , dis_direction277 , lerpResult1060);
				float dis_tex661 = lerpResult916;
				float temp_output_130_0 = (0.0 + (dis_tex661 - -0.5) * (1.0 - 0.0) / (1.5 - -0.5));
				float temp_output_105_0 = step( lerpResult913 , temp_output_130_0 );
				float dis_edge133 = ( temp_output_105_0 - step( ( lerpResult913 + _Float17 ) , temp_output_130_0 ) );
				float4 lerpResult131 = lerp( ( ( ( _Float28 * pow( lerpResult330 , _Float30 ) ) + lerpResult600 ) * IN.ase_color * lerpResult1145 * lerpResult347 ) , _Color1 , dis_edge133);
				float2 appendResult1178 = (float2(_Vector10.x , _Vector10.y));
				float3 appendResult1172 = (float3(1.0 , _Vector10.z , 0.0));
				float3 appendResult1173 = (float3(_Vector10.w , 1.0 , 0.0));
				float2 uv_normallight = IN.ase_texcoord3.yz * _normallight_ST.xy + _normallight_ST.zw;
				float2 panner1177 = ( 1.0 * _Time.y * appendResult1178 + mul( float3x3(appendResult1172, appendResult1173, float3(0,0,1)), float3( uv_normallight ,  0.0 ) ).xy);
				float3 unpack1147 = UnpackNormalScale( tex2D( _normallight, panner1177 ), _Float146 );
				unpack1147.z = lerp( 1, unpack1147.z, saturate(_Float146) );
				float3 tanNormal957 = unpack1147;
				float3 worldNormal957 = normalize( float3(dot(tanToWorld0,tanNormal957), dot(tanToWorld1,tanNormal957), dot(tanToWorld2,tanNormal957)) );
				float dotResult960 = dot( _MainLightPosition.xyz , worldNormal957 );
				float3 appendResult996 = (float3(_Vector34.x , _Vector34.y , _Vector34.z));
				float pointlight1007 = distance( appendResult996 , WorldPosition );
				float lerpResult1008 = lerp( dotResult960 , pointlight1007 , _Float137);
				float smoothstepResult968 = smoothstep( ( 1.0 - _Float133 ) , _Float133 , ( ( lerpResult1008 + 1.0 ) - ( _Float132 * 2.0 ) ));
				float lit971 = smoothstepResult968;
				float4 lerpResult969 = lerp( ( _Color4 * lerpResult131 ) , ( _Color5 * lerpResult131 ) , lit971);
				float4 lerpResult977 = lerp( lerpResult131 , lerpResult969 , _Float134);
				float2 appendResult1191 = (float2(_Vector12.x , _Vector12.y));
				float3 appendResult1187 = (float3(1.0 , _Vector12.z , 0.0));
				float3 appendResult1186 = (float3(_Vector12.w , 1.0 , 0.0));
				float2 uv_normal = IN.ase_texcoord3.yz * _normal_ST.xy + _normal_ST.zw;
				float2 panner1193 = ( 1.0 * _Time.y * appendResult1191 + mul( float3x3(appendResult1187, appendResult1186, float3(0,0,1)), float3( uv_normal ,  0.0 ) ).xy);
				float3 unpack1070 = UnpackNormalScale( tex2D( _normal, panner1193 ), _Float18 );
				unpack1070.z = lerp( 1, unpack1070.z, saturate(_Float18) );
				float3 tanNormal1064 = unpack1070;
				float3 worldNormal1064 = float3(dot(tanToWorld0,tanNormal1064), dot(tanToWorld1,tanNormal1064), dot(tanToWorld2,tanNormal1064));
				float4 matcap1074 = ( tex2D( _matcap, ( ( (mul( UNITY_MATRIX_V, float4( worldNormal1064 , 0.0 ) ).xyz).xy + float2( 1,1 ) ) * float2( 0.5,0.5 ) ) ) * _Float140 );
				float4 lerpResult1078 = lerp( float4( 0,0,0,0 ) , matcap1074 , _Float141);
				float4 temp_output_1076_0 = ( lerpResult977 + lerpResult1078 );
				
				float lerpResult402 = lerp( tex2DNode1.a , tex2DNode1.r , _maintex_alpha);
				float lerpResult374 = lerp( lerpResult402 , ( pow( abs( lerpResult402 ) , _Float34 ) * _Float37 ) , _Float36);
				float4 texCoord1089 = IN.ase_texcoord10;
				texCoord1089.xy = IN.ase_texcoord10.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult1090 = lerp( _Float8 , texCoord1089.z , _Float142);
				float smoothstepResult32 = smoothstep( lerpResult1090 , ( 1.0 - lerpResult1090 ) , saturate( ( ( lerpResult916 + 1.0 ) - ( lerpResult913 * 2.0 ) ) ));
				float dis_soft122 = smoothstepResult32;
				float dis_bright124 = temp_output_105_0;
				float lerpResult413 = lerp( dis_soft122 , dis_bright124 , _Float25);
				float lerpResult338 = lerp( depthfade126 , 1.0 , depthfade_switch334);
				float2 appendResult480 = (float2(_Vector11.x , _Vector11.y));
				float2 uv_Mask = IN.ase_texcoord3.yz * _Mask_ST.xy + _Mask_ST.zw;
				float2 uv2_Mask = IN.ase_texcoord6.xy * _Mask_ST.xy + _Mask_ST.zw;
				float2 lerpResult931 = lerp( uv_Mask , uv2_Mask , uv2930);
				float3 appendResult823 = (float3(1.0 , _Vector11.z , 0.0));
				float3 appendResult824 = (float3(_Vector11.w , 1.0 , 0.0));
				float2 appendResult481 = (float2(_Mask_ST.z , _Mask_ST.w));
				float4 texCoord74 = IN.ase_texcoord6;
				texCoord74.xy = IN.ase_texcoord6.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult75 = (float2(texCoord74.z , texCoord74.w));
				float2 lerpResult474 = lerp( appendResult481 , appendResult75 , _Float12);
				float2 CenteredUV15_g99 = ( IN.ase_texcoord3.yz - float2( 0.5,0.5 ) );
				float2 break17_g99 = CenteredUV15_g99;
				float2 appendResult23_g99 = (float2(( length( CenteredUV15_g99 ) * _Mask_ST.x * 2.0 ) , ( atan2( break17_g99.x , break17_g99.y ) * ( 1.0 / TWO_PI ) * _Mask_ST.y )));
				float2 lerpResult471 = lerp( appendResult481 , appendResult75 , _Float12);
				float2 lerpResult467 = lerp( ( mul( float3( lerpResult931 ,  0.0 ), float3x3(appendResult823, appendResult824, float3(0,0,1)) ).xy + lerpResult474 ) , (mul( float3( appendResult23_g99 ,  0.0 ), float3x3(appendResult823, appendResult824, float3(0,0,1)) ).xy*float2( 1,1 ) + lerpResult471) , _Float51);
				float2 panner79 = ( 1.0 * _Time.y * appendResult480 + lerpResult467);
				float noise_intensity_mask736 = ( _Float80 * 0.1 );
				float temp_output_322_0 = ( noise70 * noise_intensity_mask736 );
				float cos392 = cos( ( _Float43 * PI ) );
				float sin392 = sin( ( _Float43 * PI ) );
				float2 rotator392 = mul( ( panner79 + temp_output_322_0 ) - float2( 0.5,0.5 ) , float2x2( cos392 , -sin392 , sin392 , cos392 )) + float2( 0.5,0.5 );
				float2 break617 = rotator392;
				float clampResult618 = clamp( break617.x , 0.0 , 1.0 );
				float lerpResult769 = lerp( break617.x , clampResult618 , _Float64);
				float clampResult619 = clamp( break617.y , 0.0 , 1.0 );
				float lerpResult771 = lerp( break617.y , clampResult619 , _Float82);
				float2 appendResult616 = (float2(lerpResult769 , lerpResult771));
				float4 tex2DNode8 = tex2D( _Mask, appendResult616 );
				float lerpResult406 = lerp( tex2DNode8.a , tex2DNode8.r , _mask01_alpha);
				float2 appendResult485 = (float2(_Vector13.x , _Vector13.y));
				float2 uv_Mask1 = IN.ase_texcoord3.yz * _Mask1_ST.xy + _Mask1_ST.zw;
				float2 uv2_Mask1 = IN.ase_texcoord6.xy * _Mask1_ST.xy + _Mask1_ST.zw;
				float2 lerpResult934 = lerp( uv_Mask1 , uv2_Mask1 , uv2930);
				float3 appendResult833 = (float3(1.0 , _Vector13.z , 0.0));
				float3 appendResult834 = (float3(_Vector13.w , 1.0 , 0.0));
				float2 appendResult486 = (float2(_Mask1_ST.z , _Mask1_ST.w));
				float2 CenteredUV15_g98 = ( IN.ase_texcoord3.yz - float2( 0.5,0.5 ) );
				float2 break17_g98 = CenteredUV15_g98;
				float2 appendResult23_g98 = (float2(( length( CenteredUV15_g98 ) * _Mask1_ST.x * 2.0 ) , ( atan2( break17_g98.x , break17_g98.y ) * ( 1.0 / TWO_PI ) * _Mask1_ST.y )));
				float2 lerpResult495 = lerp( ( mul( float3( lerpResult934 ,  0.0 ), float3x3(appendResult833, appendResult834, float3(0,0,1)) ).xy + appendResult486 ) , (mul( float3( appendResult23_g98 ,  0.0 ), float3x3(appendResult833, appendResult834, float3(0,0,1)) ).xy*float2( 1,1 ) + appendResult486) , _Float52);
				float2 panner216 = ( 1.0 * _Time.y * appendResult485 + lerpResult495);
				float cos389 = cos( ( _Float42 * PI ) );
				float sin389 = sin( ( _Float42 * PI ) );
				float2 rotator389 = mul( ( temp_output_322_0 + panner216 ) - float2( 0.5,0.5 ) , float2x2( cos389 , -sin389 , sin389 , cos389 )) + float2( 0.5,0.5 );
				float2 break623 = rotator389;
				float clampResult624 = clamp( break623.x , 0.0 , 1.0 );
				float lerpResult772 = lerp( break623.x , clampResult624 , _Float65);
				float clampResult625 = clamp( break623.y , 0.0 , 1.0 );
				float lerpResult773 = lerp( break623.y , clampResult625 , _Float83);
				float2 appendResult622 = (float2(lerpResult772 , lerpResult773));
				float4 tex2DNode218 = tex2D( _Mask1, appendResult622 );
				float lerpResult407 = lerp( tex2DNode218.a , tex2DNode218.r , _mask02_alpha);
				float Mask82 = ( lerpResult406 * lerpResult407 );
				float temp_output_6_0 = ( lerpResult374 * IN.ase_color.a * _Color0.a * lerpResult413 * _Float15 * lerpResult338 * Mask82 * lerpResult347 );
				float clampResult602 = clamp( temp_output_6_0 , 0.0 , 1.0 );
				float lerpResult656 = lerp( temp_output_6_0 , clampResult602 , _Float70);
				clip( dis_tex661 - _Float72);
				
				float3 BakedAlbedo = 0;
				float3 BakedEmission = 0;
				float3 Color = ( temp_output_1076_0 * _Float14 ).rgb;
				float Alpha = lerpResult656;
				float AlphaClipThreshold = 0.5;
				float AlphaClipThresholdShadow = 0.5;

				#ifdef _ALPHATEST_ON
					clip( Alpha - AlphaClipThreshold );
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif

				#ifdef ASE_FOG
					Color = MixFog( Color, IN.fogFactor );
				#endif

				return half4( Color, Alpha );
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask 0
			AlphaToMask Off

			HLSLPROGRAM
			#pragma multi_compile_instancing
			#define _RECEIVE_SHADOWS_OFF 1
			#define ASE_SRP_VERSION 999999
			#define REQUIRE_DEPTH_TEXTURE 1

			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x

			#pragma vertex vert
			#pragma fragment frag

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_FRAG_COLOR
			#define ASE_NEEDS_VERT_POSITION


			struct VertexInput
			{
				float4 vertex : POSITION;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_tangent : TANGENT;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct VertexOutput
			{
				float4 clipPos : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 worldPos : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
				float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_color : COLOR;
				float4 ase_texcoord9 : TEXCOORD9;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _Vector23;
			float4 _Color5;
			float4 _Color4;
			float4 _Vector35;
			float4 _TextureSample0_ST;
			float4 _Vector17;
			float4 _Vector15;
			float4 _Color1;
			float4 _Color6;
			float4 _Vector19;
			float4 _vertextex_ST;
			float4 _Color3;
			float4 _Vector10;
			float4 _Color0;
			float4 _Vector25;
			float4 _vertextex1_ST;
			float4 _Vector9;
			float4 _Gradienttex_ST;
			float4 _Vector0;
			float4 _maintex_ST;
			float4 _Vector7;
			float4 _flowmaptex_ST;
			float4 _parallax_ST;
			float4 _Vector33;
			float4 _noisemask_ST;
			float4 _Vector32;
			float4 _normallight_ST;
			float4 _dissolvetex_ST;
			float4 _Vector34;
			float4 _Mask1_ST;
			float4 _Vector13;
			float4 _Mask_ST;
			float4 _Vector11;
			float4 _normal_ST;
			float4 _Vector12;
			float4 _noise_ST;
			float3 _Vector5;
			float _Float134;
			float _Float29;
			float _Float81;
			float _Float63;
			float _Float40;
			float _Float50;
			float _Float132;
			float _Float51;
			float _Float80;
			float _Float15;
			float _Float43;
			float _Float39;
			float _Float32;
			float _Float133;
			float _Float137;
			float _Float9;
			float _Float52;
			float _Float42;
			float _Float44;
			float _Float54;
			float _mask01_alpha;
			float _Float47;
			float _Float61;
			float _Float8;
			float _Float17;
			float _Float41;
			float _Float79;
			float _Float53;
			float _Float18;
			float _Float140;
			float _Float129;
			float _Float11;
			float _Float6;
			float _Float130;
			float _Float141;
			float _Float145;
			float _Float19;
			float _power3;
			float _Float14;
			float _Float35;
			float _maintex_alpha;
			float _Float34;
			float _Float146;
			float _Float36;
			float _Float33;
			float _Float37;
			float _Float131;
			float _Float57;
			float _Float83;
			float _Float69;
			float _Float142;
			float _Float86;
			float _Float89;
			float _Float68;
			float _Float64;
			float _Float88;
			float _Float25;
			float _Float135;
			float _Float48;
			float _Float70;
			float _Float1;
			float _Maintex_Group5;
			float _Float78;
			float _Maintex_Group;
			float _Float82;
			float _Float20;
			float _Float85;
			float _Float67;
			float _Float73;
			float _Float84;
			float _Float76;
			float _Float10;
			float _Float65;
			float _Float31;
			float _Float5;
			float _Float139;
			float _Float87;
			float _Float66;
			float _Float71;
			float _Float62;
			float _Float12;
			float _Float74;
			float _Maintex_Group4;
			float _Vertex_Group;
			float _Float22;
			float _Float75;
			float _Float77;
			float _Float28;
			float _Float55;
			float _Float0;
			float _Float45;
			float _Float16;
			float _Float144;
			float _Float49;
			float _Float38;
			float _refplane;
			float _Float143;
			float _mask02_alpha;
			float _Float30;
			float _Maintex_Group1;
			float _Float56;
			float _Float60;
			float _Ztestmode2;
			float _Custom_Group1;
			float _Disolove_Group;
			float _Mask_Group;
			float _Color_Group2;
			float _Depthfade_Group1;
			float _Fresnel_Group2;
			float _Noise_Group;
			float _Float4;
			float _Maintex_Group3;
			float _Maintex_Group2;
			float _Ztestmode1;
			float _Ztestmode;
			float _Float46;
			float _Float2;
			float _Float72;
			#ifdef TESSELLATION_ON
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END
			sampler2D _vertextex;
			sampler2D _vertextex1;
			sampler2D _maintex;
			sampler2D _parallax;
			sampler1D _noisemask;
			sampler2D _noise;
			sampler2D _flowmaptex;
			sampler2D _dissolvetex;
			sampler1D _TextureSample0;
			uniform float4 _CameraDepthTexture_TexelSize;
			sampler2D _Mask;
			sampler2D _Mask1;


			inline float2 POM( sampler2D heightMap, float2 uvs, float2 dx, float2 dy, float3 normalWorld, float3 viewWorld, float3 viewDirTan, int minSamples, int maxSamples, float parallax, float refPlane, float2 tilling, float2 curv, int index )
			{
				float3 result = 0;
				int stepIndex = 0;
				int numSteps = ( int )lerp( (float)maxSamples, (float)minSamples, saturate( dot( normalWorld, viewWorld ) ) );
				float layerHeight = 1.0 / numSteps;
				float2 plane = parallax * ( viewDirTan.xy / viewDirTan.z );
				uvs.xy += refPlane * plane;
				float2 deltaTex = -plane * layerHeight;
				float2 prevTexOffset = 0;
				float prevRayZ = 1.0f;
				float prevHeight = 0.0f;
				float2 currTexOffset = deltaTex;
				float currRayZ = 1.0f - layerHeight;
				float currHeight = 0.0f;
				float intersection = 0;
				float2 finalTexOffset = 0;
				while ( stepIndex < numSteps + 1 )
				{
				 	currHeight = tex2Dgrad( heightMap, uvs + currTexOffset, dx, dy ).r;
				 	if ( currHeight > currRayZ )
				 	{
				 	 	stepIndex = numSteps + 1;
				 	}
				 	else
				 	{
				 	 	stepIndex++;
				 	 	prevTexOffset = currTexOffset;
				 	 	prevRayZ = currRayZ;
				 	 	prevHeight = currHeight;
				 	 	currTexOffset += deltaTex;
				 	 	currRayZ -= layerHeight;
				 	}
				}
				int sectionSteps = 10;
				int sectionIndex = 0;
				float newZ = 0;
				float newHeight = 0;
				while ( sectionIndex < sectionSteps )
				{
				 	intersection = ( prevHeight - prevRayZ ) / ( prevHeight - currHeight + currRayZ - prevRayZ );
				 	finalTexOffset = prevTexOffset + intersection * deltaTex;
				 	newZ = prevRayZ - intersection * layerHeight;
				 	newHeight = tex2Dgrad( heightMap, uvs + finalTexOffset, dx, dy ).r;
				 	if ( newHeight > newZ )
				 	{
				 	 	currTexOffset = finalTexOffset;
				 	 	currHeight = newHeight;
				 	 	currRayZ = newZ;
				 	 	deltaTex = intersection * deltaTex;
				 	 	layerHeight = intersection * layerHeight;
				 	}
				 	else
				 	{
				 	 	prevTexOffset = finalTexOffset;
				 	 	prevHeight = newHeight;
				 	 	prevRayZ = newZ;
				 	 	deltaTex = ( 1 - intersection ) * deltaTex;
				 	 	layerHeight = ( 1 - intersection ) * layerHeight;
				 	}
				 	sectionIndex++;
				}
				return uvs.xy + finalTexOffset;
			}
			

			VertexOutput VertexFunction( VertexInput v  )
			{
				VertexOutput o = (VertexOutput)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

				float2 appendResult557 = (float2(_Vector19.x , _Vector19.y));
				float2 uv_vertextex = v.ase_texcoord.xy * _vertextex_ST.xy + _vertextex_ST.zw;
				float2 uv2_vertextex = v.ase_texcoord1 * _vertextex_ST.xy + _vertextex_ST.zw;
				float uv2930 = _Float131;
				float2 lerpResult949 = lerp( uv_vertextex , uv2_vertextex , uv2930);
				float3 appendResult895 = (float3(1.0 , _Vector19.z , 0.0));
				float3 appendResult897 = (float3(_Vector19.w , 1.0 , 0.0));
				float2 temp_output_898_0 = mul( float3( lerpResult949 ,  0.0 ), float3x3(appendResult895, appendResult897, float3(0,0,1)) ).xy;
				float2 appendResult546 = (float2(_vertextex_ST.z , _vertextex_ST.w));
				float2 CenteredUV15_g100 = ( v.ase_texcoord.xy - float2( 0.5,0.5 ) );
				float2 break17_g100 = CenteredUV15_g100;
				float2 appendResult23_g100 = (float2(( length( CenteredUV15_g100 ) * _vertextex_ST.x * 2.0 ) , ( atan2( break17_g100.x , break17_g100.y ) * ( 1.0 / TWO_PI ) * _vertextex_ST.y )));
				float2 lerpResult556 = lerp( ( temp_output_898_0 + appendResult546 ) , (( appendResult23_g100 * temp_output_898_0 )*float2( 1,1 ) + appendResult546) , _Float56);
				float2 panner168 = ( 1.0 * _Time.y * appendResult557 + lerpResult556);
				float cos398 = cos( ( _Float45 * PI ) );
				float sin398 = sin( ( _Float45 * PI ) );
				float2 rotator398 = mul( panner168 - float2( 0.5,0.5 ) , float2x2( cos398 , -sin398 , sin398 , cos398 )) + float2( 0.5,0.5 );
				float2 break644 = rotator398;
				float clampResult646 = clamp( break644.x , 0.0 , 1.0 );
				float lerpResult790 = lerp( break644.x , clampResult646 , _Float68);
				float clampResult645 = clamp( break644.y , 0.0 , 1.0 );
				float lerpResult791 = lerp( break644.y , clampResult645 , _Float89);
				float2 appendResult647 = (float2(lerpResult790 , lerpResult791));
				float3 temp_cast_4 = (1.0).xxx;
				float3 lerpResult993 = lerp( temp_cast_4 , v.ase_normal , _Float135);
				float4 texCoord167 = v.ase_texcoord2;
				texCoord167.xy = v.ase_texcoord2.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult176 = lerp( 1.0 , texCoord167.w , _Float22);
				float2 appendResult719 = (float2(_Vector25.x , _Vector25.y));
				float2 uv_vertextex1 = v.ase_texcoord.xy * _vertextex1_ST.xy + _vertextex1_ST.zw;
				float2 uv2_vertextex1 = v.ase_texcoord1.xy * _vertextex1_ST.xy + _vertextex1_ST.zw;
				float2 lerpResult946 = lerp( uv_vertextex1 , uv2_vertextex1 , uv2930);
				float3 appendResult886 = (float3(1.0 , _Vector25.z , 0.0));
				float3 appendResult888 = (float3(_Vector25.w , 1.0 , 0.0));
				float2 appendResult710 = (float2(_vertextex1_ST.z , _vertextex1_ST.w));
				float2 CenteredUV15_g101 = ( v.ase_texcoord.xy - float2( 0.5,0.5 ) );
				float2 break17_g101 = CenteredUV15_g101;
				float2 appendResult23_g101 = (float2(( length( CenteredUV15_g101 ) * _vertextex1_ST.x * 2.0 ) , ( atan2( break17_g101.x , break17_g101.y ) * ( 1.0 / TWO_PI ) * _vertextex1_ST.y )));
				float2 lerpResult728 = lerp( ( mul( float3( lerpResult946 ,  0.0 ), float3x3(appendResult886, appendResult888, float3(0,0,1)) ).xy + appendResult710 ) , (mul( float3( appendResult23_g101 ,  0.0 ), float3x3(appendResult886, appendResult888, float3(0,0,1)) ).xy*float2( 1,1 ) + appendResult710) , _Float75);
				float2 panner725 = ( 1.0 * _Time.y * appendResult719 + lerpResult728);
				float cos726 = cos( ( _Float77 * PI ) );
				float sin726 = sin( ( _Float77 * PI ) );
				float2 rotator726 = mul( panner725 - float2( 0.5,0.5 ) , float2x2( cos726 , -sin726 , sin726 , cos726 )) + float2( 0.5,0.5 );
				float2 break720 = rotator726;
				float clampResult721 = clamp( break720.x , 0.0 , 1.0 );
				float lerpResult787 = lerp( break720.x , clampResult721 , _Float78);
				float clampResult722 = clamp( break720.y , 0.0 , 1.0 );
				float lerpResult789 = lerp( break720.y , clampResult722 , _Float88);
				float2 appendResult723 = (float2(lerpResult787 , lerpResult789));
				float3 vertexoffset181 = ( (_Vector32.z + (tex2Dlod( _vertextex, float4( appendResult647, 0, 0.0) ).r - _Vector32.x) * (_Vector32.w - _Vector32.z) / (_Vector32.y - _Vector32.x)) * lerpResult993 * _Vector5 * lerpResult176 * tex2Dlod( _vertextex1, float4( appendResult723, 0, 0.0) ).r );
				
				float4 ase_clipPos = TransformObjectToHClip((v.vertex).xyz);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord3 = screenPos;
				float3 ase_worldTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
				o.ase_texcoord5.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord6.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.ase_tangent.w * unity_WorldTransformParams.w;
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord7.xyz = ase_worldBitangent;
				float3 customSurfaceDepth754 = v.vertex.xyz;
				float customEye754 = -TransformWorldToView(TransformObjectToWorld(customSurfaceDepth754)).z;
				o.ase_texcoord2.z = customEye754;
				float3 vertexPos97 = v.vertex.xyz;
				float4 ase_clipPos97 = TransformObjectToHClip((vertexPos97).xyz);
				float4 screenPos97 = ComputeScreenPos(ase_clipPos97);
				o.ase_texcoord9 = screenPos97;
				
				o.ase_texcoord2.xy = v.ase_texcoord.xy;
				o.ase_texcoord4 = v.ase_texcoord1;
				o.ase_texcoord8 = v.ase_texcoord2;
				o.ase_color = v.ase_color;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord2.w = 0;
				o.ase_texcoord5.w = 0;
				o.ase_texcoord6.w = 0;
				o.ase_texcoord7.w = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = vertexoffset181;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif

				v.ase_normal = v.ase_normal;

				float3 positionWS = TransformObjectToWorld( v.vertex.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				o.worldPos = positionWS;
				#endif

				o.clipPos = TransformWorldToHClip( positionWS );
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = clipPos;
					o.shadowCoord = GetShadowCoord( vertexInput );
				#endif
				return o;
			}

			#if defined(TESSELLATION_ON)
			struct VertexControl
			{
				float4 vertex : INTERNALTESSPOS;
				float3 ase_normal : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_tangent : TANGENT;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( VertexInput v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.vertex = v.vertex;
				o.ase_normal = v.ase_normal;
				o.ase_texcoord = v.ase_texcoord;
				o.ase_texcoord1 = v.ase_texcoord1;
				o.ase_texcoord2 = v.ase_texcoord2;
				o.ase_tangent = v.ase_tangent;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(v[0].vertex, v[1].vertex, v[2].vertex, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			VertexOutput DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				VertexInput o = (VertexInput) 0;
				o.vertex = patch[0].vertex * bary.x + patch[1].vertex * bary.y + patch[2].vertex * bary.z;
				o.ase_normal = patch[0].ase_normal * bary.x + patch[1].ase_normal * bary.y + patch[2].ase_normal * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				o.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				o.ase_texcoord2 = patch[0].ase_texcoord2 * bary.x + patch[1].ase_texcoord2 * bary.y + patch[2].ase_texcoord2 * bary.z;
				o.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.vertex.xyz - patch[i].ase_normal * (dot(o.vertex.xyz, patch[i].ase_normal) - dot(patch[i].vertex.xyz, patch[i].ase_normal));
				float phongStrength = _TessPhongStrength;
				o.vertex.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.vertex.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			VertexOutput vert ( VertexInput v )
			{
				return VertexFunction( v );
			}
			#endif

			half4 frag(VertexOutput IN , half ase_vface : VFACE ) : SV_TARGET
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( IN );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
				float3 WorldPosition = IN.worldPos;
				#endif
				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = IN.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 appendResult440 = (float2(_Vector0.x , _Vector0.y));
				float2 uv_maintex = IN.ase_texcoord2.xy * _maintex_ST.xy + _maintex_ST.zw;
				float4 screenPos = IN.ase_texcoord3;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float2 appendResult1132 = (float2(ase_screenPosNorm.x , ase_screenPosNorm.y));
				float2 appendResult1131 = (float2(_maintex_ST.x , _maintex_ST.y));
				float2 appendResult1130 = (float2(_maintex_ST.z , _maintex_ST.w));
				float2 lerpResult1127 = lerp( uv_maintex , (appendResult1132*appendResult1131 + appendResult1130) , _Float144);
				float3 appendResult799 = (float3(1.0 , _Vector0.z , 0.0));
				float3 appendResult803 = (float3(_Vector0.w , 1.0 , 0.0));
				float2 appendResult433 = (float2(_maintex_ST.z , _maintex_ST.w));
				float4 texCoord39 = IN.ase_texcoord4;
				texCoord39.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult42 = (float2(texCoord39.x , texCoord39.y));
				float2 lerpResult59 = lerp( appendResult433 , appendResult42 , _Float10);
				float2 CenteredUV15_g90 = ( IN.ase_texcoord2.xy - float2( 0.5,0.5 ) );
				float2 break17_g90 = CenteredUV15_g90;
				float2 appendResult23_g90 = (float2(( length( CenteredUV15_g90 ) * _maintex_ST.x * 2.0 ) , ( atan2( break17_g90.x , break17_g90.y ) * ( 1.0 / TWO_PI ) * _maintex_ST.y )));
				float2 lerpResult449 = lerp( appendResult433 , appendResult42 , _Float10);
				float2 lerpResult444 = lerp( ( mul( float3( lerpResult1127 ,  0.0 ), float3x3(appendResult799, appendResult803, float3(0,0,1)) ).xy + lerpResult59 ) , (mul( float3( appendResult23_g90 ,  0.0 ), float3x3(appendResult799, appendResult803, float3(0,0,1)) ).xy*float2( 1,1 ) + lerpResult449) , _Float49);
				float2 panner36 = ( 1.0 * _Time.y * appendResult440 + lerpResult444);
				float2 maintexUV_00161 = panner36;
				float3 ase_worldTangent = IN.ase_texcoord5.xyz;
				float3 ase_worldNormal = IN.ase_texcoord6.xyz;
				float3 ase_worldBitangent = IN.ase_texcoord7.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				ase_tanViewDir = normalize(ase_tanViewDir);
				float2 OffsetPOM1092 = POM( _parallax, maintexUV_00161, ddx(maintexUV_00161), ddy(maintexUV_00161), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, 128, 128, ( _Float38 * 0.1 ), _refplane, _parallax_ST.xy, float2(0,0), 0 );
				float2 parallax1097 = OffsetPOM1092;
				float2 lerpResult1099 = lerp( maintexUV_00161 , parallax1097 , _Float143);
				float2 appendResult687 = (float2(_Vector23.x , _Vector23.y));
				float2 uv_noisemask = IN.ase_texcoord2.xy * _noisemask_ST.xy + _noisemask_ST.zw;
				float2 uv2_noisemask = IN.ase_texcoord4.xy * _noisemask_ST.xy + _noisemask_ST.zw;
				float uv2930 = _Float131;
				float2 lerpResult938 = lerp( uv_noisemask , uv2_noisemask , uv2930);
				float3 appendResult866 = (float3(1.0 , _Vector23.z , 0.0));
				float3 appendResult865 = (float3(_Vector23.w , 1.0 , 0.0));
				float2 appendResult679 = (float2(_noisemask_ST.z , _noisemask_ST.w));
				float2 CenteredUV15_g47 = ( IN.ase_texcoord2.xy - float2( 0.5,0.5 ) );
				float2 break17_g47 = CenteredUV15_g47;
				float2 appendResult23_g47 = (float2(( length( CenteredUV15_g47 ) * _noisemask_ST.x * 2.0 ) , ( atan2( break17_g47.x , break17_g47.y ) * ( 1.0 / TWO_PI ) * _noisemask_ST.y )));
				float2 lerpResult688 = lerp( ( mul( float3( lerpResult938 ,  0.0 ), float3x3(appendResult866, appendResult865, float3(0,0,1)) ).xy + appendResult679 ) , (mul( float3( appendResult23_g47 ,  0.0 ), float3x3(appendResult866, appendResult865, float3(0,0,1)) ).xy*float2( 1,1 ) + appendResult679) , _Float57);
				float2 panner697 = ( 1.0 * _Time.y * appendResult687 + lerpResult688);
				float cos698 = cos( ( _Float74 * PI ) );
				float sin698 = sin( ( _Float74 * PI ) );
				float2 rotator698 = mul( panner697 - float2( 0.5,0.5 ) , float2x2( cos698 , -sin698 , sin698 , cos698 )) + float2( 0.5,0.5 );
				float2 break689 = rotator698;
				float clampResult690 = clamp( break689.x , 0.0 , 1.0 );
				float lerpResult775 = lerp( break689.x , clampResult690 , _Float73);
				float clampResult691 = clamp( break689.y , 0.0 , 1.0 );
				float lerpResult776 = lerp( break689.x , clampResult691 , _Float84);
				float2 appendResult693 = (float2(lerpResult775 , lerpResult776));
				float4 tex1DNode564 = tex1D( _noisemask, appendResult693.x );
				float2 appendResult530 = (float2(_Vector17.x , _Vector17.y));
				float2 uv_noise = IN.ase_texcoord2.xy * _noise_ST.xy + _noise_ST.zw;
				float2 uv2_noise = IN.ase_texcoord4.xy * _noise_ST.xy + _noise_ST.zw;
				float2 lerpResult941 = lerp( uv_noise , uv2_noise , uv2930);
				float3 appendResult876 = (float3(1.0 , _Vector17.z , 0.0));
				float3 appendResult878 = (float3(_Vector17.w , 1.0 , 0.0));
				float2 appendResult531 = (float2(_noise_ST.z , _noise_ST.w));
				float2 CenteredUV15_g46 = ( IN.ase_texcoord2.xy - float2( 0.5,0.5 ) );
				float2 break17_g46 = CenteredUV15_g46;
				float2 appendResult23_g46 = (float2(( length( CenteredUV15_g46 ) * _noise_ST.x * 2.0 ) , ( atan2( break17_g46.x , break17_g46.y ) * ( 1.0 / TWO_PI ) * _noise_ST.y )));
				float2 lerpResult539 = lerp( ( mul( float3( lerpResult941 ,  0.0 ), float3x3(appendResult876, appendResult878, float3(0,0,1)) ).xy + appendResult531 ) , (mul( float3( appendResult23_g46 ,  0.0 ), float3x3(appendResult876, appendResult878, float3(0,0,1)) ).xy*float2( 1,1 ) + appendResult531) , _Float54);
				float2 panner53 = ( 1.0 * _Time.y * appendResult530 + lerpResult539);
				float cos395 = cos( ( _Float44 * PI ) );
				float sin395 = sin( ( _Float44 * PI ) );
				float2 rotator395 = mul( panner53 - float2( 0.5,0.5 ) , float2x2( cos395 , -sin395 , sin395 , cos395 )) + float2( 0.5,0.5 );
				float2 break638 = rotator395;
				float clampResult640 = clamp( break638.x , 0.0 , 1.0 );
				float lerpResult778 = lerp( break638.x , clampResult640 , _Float67);
				float clampResult639 = clamp( break638.y , 0.0 , 1.0 );
				float lerpResult780 = lerp( break638.y , clampResult639 , _Float85);
				float2 appendResult641 = (float2(lerpResult778 , lerpResult780));
				float temp_output_923_0 = (_Vector33.z + (tex2D( _noise, appendResult641 ).r - _Vector33.x) * (_Vector33.w - _Vector33.z) / (_Vector33.y - _Vector33.x));
				float lerpResult701 = lerp( ( tex1DNode564.r * temp_output_923_0 ) , ( tex1DNode564.r + temp_output_923_0 ) , _Float76);
				float noise70 = lerpResult701;
				float noise_intensity_main67 = ( _Float9 * 0.1 );
				float2 uv_flowmaptex = IN.ase_texcoord2.xy * _flowmaptex_ST.xy + _flowmaptex_ST.zw;
				float4 tex2DNode241 = tex2D( _flowmaptex, uv_flowmaptex );
				float2 appendResult242 = (float2(tex2DNode241.r , tex2DNode241.g));
				float2 flowmap285 = appendResult242;
				float flowmap_intensity311 = _Float32;
				float4 texCoord100 = IN.ase_texcoord8;
				texCoord100.xy = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float flpwmap_custom_switch316 = _Float31;
				float lerpResult99 = lerp( flowmap_intensity311 , texCoord100.y , flpwmap_custom_switch316);
				float2 lerpResult283 = lerp( ( lerpResult1099 + ( noise70 * noise_intensity_main67 ) ) , flowmap285 , lerpResult99);
				float cos377 = cos( ( _Float39 * PI ) );
				float sin377 = sin( ( _Float39 * PI ) );
				float2 rotator377 = mul( lerpResult283 - float2( 0.5,0.5 ) , float2x2( cos377 , -sin377 , sin377 , cos377 )) + float2( 0.5,0.5 );
				float2 break603 = rotator377;
				float clampResult604 = clamp( break603.x , 0.0 , 1.0 );
				float lerpResult607 = lerp( break603.x , clampResult604 , _Float62);
				float clampResult605 = clamp( break603.y , 0.0 , 1.0 );
				float lerpResult764 = lerp( break603.y , clampResult605 , _Float71);
				float2 appendResult606 = (float2(lerpResult607 , lerpResult764));
				float4 tex2DNode1 = tex2D( _maintex, appendResult606 );
				float lerpResult402 = lerp( tex2DNode1.a , tex2DNode1.r , _maintex_alpha);
				float lerpResult374 = lerp( lerpResult402 , ( pow( abs( lerpResult402 ) , _Float34 ) * _Float37 ) , _Float36);
				float4 texCoord1089 = IN.ase_texcoord8;
				texCoord1089.xy = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult1090 = lerp( _Float8 , texCoord1089.z , _Float142);
				float2 appendResult501 = (float2(_Vector15.x , _Vector15.y));
				float2 uv_dissolvetex = IN.ase_texcoord2.xy * _dissolvetex_ST.xy + _dissolvetex_ST.zw;
				float2 uv2_dissolvetex = IN.ase_texcoord4.xy * _dissolvetex_ST.xy + _dissolvetex_ST.zw;
				float2 lerpResult952 = lerp( uv_dissolvetex , uv2_dissolvetex , uv2930);
				float3 appendResult810 = (float3(1.0 , _Vector15.z , 0.0));
				float3 appendResult811 = (float3(_Vector15.w , 1.0 , 0.0));
				float2 appendResult502 = (float2(_dissolvetex_ST.z , _dissolvetex_ST.w));
				float2 CenteredUV15_g91 = ( IN.ase_texcoord2.xy - float2( 0.5,0.5 ) );
				float2 break17_g91 = CenteredUV15_g91;
				float2 appendResult23_g91 = (float2(( length( CenteredUV15_g91 ) * _dissolvetex_ST.x * 2.0 ) , ( atan2( break17_g91.x , break17_g91.y ) * ( 1.0 / TWO_PI ) * _dissolvetex_ST.y )));
				float2 lerpResult511 = lerp( ( mul( float3( lerpResult952 ,  0.0 ), float3x3(appendResult810, appendResult811, float3(0,0,1)) ).xy + appendResult502 ) , (mul( float3( appendResult23_g91 ,  0.0 ), float3x3(appendResult810, appendResult811, float3(0,0,1)) ).xy*float2( 1,1 ) + appendResult502) , _Float53);
				float2 panner58 = ( 1.0 * _Time.y * appendResult501 + lerpResult511);
				float noise_intensity_dis733 = ( _Float79 * 0.1 );
				float4 texCoord303 = IN.ase_texcoord8;
				texCoord303.xy = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult307 = lerp( flowmap_intensity311 , texCoord303.y , flpwmap_custom_switch316);
				float2 lerpResult309 = lerp( ( panner58 + ( noise70 * noise_intensity_dis733 ) ) , flowmap285 , lerpResult307);
				float2 dissolveUV92 = lerpResult309;
				float cos386 = cos( ( _Float41 * PI ) );
				float sin386 = sin( ( _Float41 * PI ) );
				float2 rotator386 = mul( dissolveUV92 - float2( 0.5,0.5 ) , float2x2( cos386 , -sin386 , sin386 , cos386 )) + float2( 0.5,0.5 );
				float2 break635 = rotator386;
				float clampResult632 = clamp( break635.x , 0.0 , 1.0 );
				float lerpResult784 = lerp( break635.x , clampResult632 , _Float66);
				float clampResult633 = clamp( break635.y , 0.0 , 1.0 );
				float lerpResult786 = lerp( break635.y , clampResult633 , _Float87);
				float2 appendResult631 = (float2(lerpResult784 , lerpResult786));
				float2 uv_TextureSample0 = IN.ase_texcoord2.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
				float2 uv2_TextureSample0 = IN.ase_texcoord4.xy * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
				float2 lerpResult955 = lerp( uv_TextureSample0 , uv2_TextureSample0 , uv2930);
				float2 CenteredUV15_g93 = ( lerpResult955 - float2( 0.5,0.5 ) );
				float2 break17_g93 = CenteredUV15_g93;
				float2 appendResult23_g93 = (float2(( length( CenteredUV15_g93 ) * 1.0 * 2.0 ) , ( atan2( break17_g93.x , break17_g93.y ) * ( 1.0 / TWO_PI ) * 1.0 )));
				float2 lerpResult568 = lerp( lerpResult955 , appendResult23_g93 , _Float53);
				float cos417 = cos( ( _Float47 * PI ) );
				float sin417 = sin( ( _Float47 * PI ) );
				float2 rotator417 = mul( lerpResult568 - float2( 0.5,0.5 ) , float2x2( cos417 , -sin417 , sin417 , cos417 )) + float2( 0.5,0.5 );
				float3 appendResult1017 = (float3(_Vector35.x , _Vector35.y , _Vector35.z));
				float lerpResult1057 = lerp( tex1D( _TextureSample0, rotator417.x ).r , distance( appendResult1017 , WorldPosition ) , _Float139);
				float dis_direction277 = lerpResult1057;
				float lerpResult1060 = lerp( _Float130 , ( 1.0 - _Float130 ) , _Float139);
				float lerpResult916 = lerp( tex2D( _dissolvetex, appendResult631 ).r , dis_direction277 , lerpResult1060);
				float4 texCoord49 = IN.ase_texcoord8;
				texCoord49.xy = IN.ase_texcoord8.xy * float2( 1,1 ) + float2( 0,0 );
				float lerpResult62 = lerp( _Float6 , texCoord49.x , _Float11);
				float lerpResult913 = lerp( lerpResult62 , ( 1.0 - IN.ase_color.a ) , _Float129);
				float smoothstepResult32 = smoothstep( lerpResult1090 , ( 1.0 - lerpResult1090 ) , saturate( ( ( lerpResult916 + 1.0 ) - ( lerpResult913 * 2.0 ) ) ));
				float dis_soft122 = smoothstepResult32;
				float dis_tex661 = lerpResult916;
				float temp_output_130_0 = (0.0 + (dis_tex661 - -0.5) * (1.0 - 0.0) / (1.5 - -0.5));
				float temp_output_105_0 = step( lerpResult913 , temp_output_130_0 );
				float dis_bright124 = temp_output_105_0;
				float lerpResult413 = lerp( dis_soft122 , dis_bright124 , _Float25);
				float customEye754 = IN.ase_texcoord2.z;
				float cameraDepthFade754 = (( customEye754 -_ProjectionParams.y - _Float0 ) / _Float55);
				float4 screenPos97 = IN.ase_texcoord9;
				float4 ase_screenPosNorm97 = screenPos97 / screenPos97.w;
				ase_screenPosNorm97.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm97.z : ase_screenPosNorm97.z * 0.5 + 0.5;
				float screenDepth97 = LinearEyeDepth(SHADERGRAPH_SAMPLE_SCENE_DEPTH( ase_screenPosNorm97.xy ),_ZBufferParams);
				float distanceDepth97 = saturate( abs( ( screenDepth97 - LinearEyeDepth( ase_screenPosNorm97.z,_ZBufferParams ) ) / ( _Float16 ) ) );
				float depthfade_switch334 = _Float5;
				float lerpResult336 = lerp( distanceDepth97 , ( 1.0 - distanceDepth97 ) , depthfade_switch334);
				float depthfade126 = ( saturate( cameraDepthFade754 ) * lerpResult336 );
				float lerpResult338 = lerp( depthfade126 , 1.0 , depthfade_switch334);
				float2 appendResult480 = (float2(_Vector11.x , _Vector11.y));
				float2 uv_Mask = IN.ase_texcoord2.xy * _Mask_ST.xy + _Mask_ST.zw;
				float2 uv2_Mask = IN.ase_texcoord4.xy * _Mask_ST.xy + _Mask_ST.zw;
				float2 lerpResult931 = lerp( uv_Mask , uv2_Mask , uv2930);
				float3 appendResult823 = (float3(1.0 , _Vector11.z , 0.0));
				float3 appendResult824 = (float3(_Vector11.w , 1.0 , 0.0));
				float2 appendResult481 = (float2(_Mask_ST.z , _Mask_ST.w));
				float4 texCoord74 = IN.ase_texcoord4;
				texCoord74.xy = IN.ase_texcoord4.xy * float2( 1,1 ) + float2( 0,0 );
				float2 appendResult75 = (float2(texCoord74.z , texCoord74.w));
				float2 lerpResult474 = lerp( appendResult481 , appendResult75 , _Float12);
				float2 CenteredUV15_g99 = ( IN.ase_texcoord2.xy - float2( 0.5,0.5 ) );
				float2 break17_g99 = CenteredUV15_g99;
				float2 appendResult23_g99 = (float2(( length( CenteredUV15_g99 ) * _Mask_ST.x * 2.0 ) , ( atan2( break17_g99.x , break17_g99.y ) * ( 1.0 / TWO_PI ) * _Mask_ST.y )));
				float2 lerpResult471 = lerp( appendResult481 , appendResult75 , _Float12);
				float2 lerpResult467 = lerp( ( mul( float3( lerpResult931 ,  0.0 ), float3x3(appendResult823, appendResult824, float3(0,0,1)) ).xy + lerpResult474 ) , (mul( float3( appendResult23_g99 ,  0.0 ), float3x3(appendResult823, appendResult824, float3(0,0,1)) ).xy*float2( 1,1 ) + lerpResult471) , _Float51);
				float2 panner79 = ( 1.0 * _Time.y * appendResult480 + lerpResult467);
				float noise_intensity_mask736 = ( _Float80 * 0.1 );
				float temp_output_322_0 = ( noise70 * noise_intensity_mask736 );
				float cos392 = cos( ( _Float43 * PI ) );
				float sin392 = sin( ( _Float43 * PI ) );
				float2 rotator392 = mul( ( panner79 + temp_output_322_0 ) - float2( 0.5,0.5 ) , float2x2( cos392 , -sin392 , sin392 , cos392 )) + float2( 0.5,0.5 );
				float2 break617 = rotator392;
				float clampResult618 = clamp( break617.x , 0.0 , 1.0 );
				float lerpResult769 = lerp( break617.x , clampResult618 , _Float64);
				float clampResult619 = clamp( break617.y , 0.0 , 1.0 );
				float lerpResult771 = lerp( break617.y , clampResult619 , _Float82);
				float2 appendResult616 = (float2(lerpResult769 , lerpResult771));
				float4 tex2DNode8 = tex2D( _Mask, appendResult616 );
				float lerpResult406 = lerp( tex2DNode8.a , tex2DNode8.r , _mask01_alpha);
				float2 appendResult485 = (float2(_Vector13.x , _Vector13.y));
				float2 uv_Mask1 = IN.ase_texcoord2.xy * _Mask1_ST.xy + _Mask1_ST.zw;
				float2 uv2_Mask1 = IN.ase_texcoord4.xy * _Mask1_ST.xy + _Mask1_ST.zw;
				float2 lerpResult934 = lerp( uv_Mask1 , uv2_Mask1 , uv2930);
				float3 appendResult833 = (float3(1.0 , _Vector13.z , 0.0));
				float3 appendResult834 = (float3(_Vector13.w , 1.0 , 0.0));
				float2 appendResult486 = (float2(_Mask1_ST.z , _Mask1_ST.w));
				float2 CenteredUV15_g98 = ( IN.ase_texcoord2.xy - float2( 0.5,0.5 ) );
				float2 break17_g98 = CenteredUV15_g98;
				float2 appendResult23_g98 = (float2(( length( CenteredUV15_g98 ) * _Mask1_ST.x * 2.0 ) , ( atan2( break17_g98.x , break17_g98.y ) * ( 1.0 / TWO_PI ) * _Mask1_ST.y )));
				float2 lerpResult495 = lerp( ( mul( float3( lerpResult934 ,  0.0 ), float3x3(appendResult833, appendResult834, float3(0,0,1)) ).xy + appendResult486 ) , (mul( float3( appendResult23_g98 ,  0.0 ), float3x3(appendResult833, appendResult834, float3(0,0,1)) ).xy*float2( 1,1 ) + appendResult486) , _Float52);
				float2 panner216 = ( 1.0 * _Time.y * appendResult485 + lerpResult495);
				float cos389 = cos( ( _Float42 * PI ) );
				float sin389 = sin( ( _Float42 * PI ) );
				float2 rotator389 = mul( ( temp_output_322_0 + panner216 ) - float2( 0.5,0.5 ) , float2x2( cos389 , -sin389 , sin389 , cos389 )) + float2( 0.5,0.5 );
				float2 break623 = rotator389;
				float clampResult624 = clamp( break623.x , 0.0 , 1.0 );
				float lerpResult772 = lerp( break623.x , clampResult624 , _Float65);
				float clampResult625 = clamp( break623.y , 0.0 , 1.0 );
				float lerpResult773 = lerp( break623.y , clampResult625 , _Float83);
				float2 appendResult622 = (float2(lerpResult772 , lerpResult773));
				float4 tex2DNode218 = tex2D( _Mask1, appendResult622 );
				float lerpResult407 = lerp( tex2DNode218.a , tex2DNode218.r , _mask02_alpha);
				float Mask82 = ( lerpResult406 * lerpResult407 );
				ase_worldViewDir = SafeNormalize( ase_worldViewDir );
				float3 normalizedWorldNormal = normalize( ase_worldNormal );
				float fresnelNdotV139 = dot( normalize( ( normalizedWorldNormal * ase_vface ) ), ase_worldViewDir );
				float fresnelNode139 = ( 0.0 + _power3 * pow( max( 1.0 - fresnelNdotV139 , 0.0001 ), _Float19 ) );
				float temp_output_140_0 = saturate( fresnelNode139 );
				float lerpResult144 = lerp( temp_output_140_0 , ( 1.0 - temp_output_140_0 ) , _Float20);
				float fresnel147 = lerpResult144;
				float lerpResult347 = lerp( 1.0 , fresnel147 , _Float33);
				float temp_output_6_0 = ( lerpResult374 * IN.ase_color.a * _Color0.a * lerpResult413 * _Float15 * lerpResult338 * Mask82 * lerpResult347 );
				float clampResult602 = clamp( temp_output_6_0 , 0.0 , 1.0 );
				float lerpResult656 = lerp( temp_output_6_0 , clampResult602 , _Float70);
				clip( dis_tex661 - _Float72);
				
				float Alpha = lerpResult656;
				float AlphaClipThreshold = 0.5;

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#ifdef LOD_FADE_CROSSFADE
					LODDitheringTransition( IN.clipPos.xyz, unity_LODFade.x );
				#endif
				return 0;
			}
			ENDHLSL
		}

	
	}
	CustomEditor "LWGUI.LWGUI"
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=18900
-1920;3;1920;1019;3271.27;-1652.693;1.312573;True;True
Node;AmplifyShaderEditor.CommentaryNode;944;-7554,-2866;Inherit;False;3602;2249;扰动;88;701;70;529;531;530;684;863;864;861;862;867;865;866;535;676;868;869;682;679;880;536;540;538;870;683;393;694;539;685;696;394;53;688;687;695;697;395;698;638;640;779;643;639;689;690;691;778;780;777;692;776;775;641;50;693;924;923;564;703;700;731;567;732;733;55;360;734;67;735;736;680;940;873;872;871;874;876;878;875;877;528;879;938;939;941;942;51;943;扰动;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;929;-8144.507,-2070.851;Inherit;False;Property;_Float131;启用2u(需关闭customdata);8;1;[Toggle];Create;False;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;930;-7854.894,-2089.837;Inherit;False;uv2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;874;-7504,-1136;Inherit;False;Constant;_Float116;Float 116;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;872;-7504,-1312;Inherit;False;Constant;_Float114;Float 114;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;871;-7504,-1360;Inherit;False;Constant;_Float113;Float 113;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;529;-7440,-848;Inherit;False;Property;_Vector17;扰动流动&斜切;97;0;Create;False;0;0;0;False;1;Sub(g4);False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;873;-7488,-1232;Inherit;False;Constant;_Float115;Float 115;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;875;-7504,-1056;Inherit;False;Constant;_Vector27;Vector 27;138;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;862;-7456,-2320;Inherit;False;Constant;_Float110;Float 110;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;51;-7424,-1632;Inherit;False;0;50;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;864;-7472,-2400;Inherit;False;Constant;_Float112;Float 112;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;878;-7232,-1232;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector4Node;684;-7440,-1792;Inherit;False;Property;_Vector23;扰动遮罩流动&斜切;104;0;Create;False;0;0;0;False;1;Sub(g4);False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;861;-7488,-2224;Inherit;False;Constant;_Float109;Float 109;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;876;-7248,-1344;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;943;-7424,-1504;Inherit;False;1;50;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;942;-7264,-1424;Inherit;False;930;uv2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;863;-7488,-2448;Inherit;False;Constant;_Float111;Float 111;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;528;-7212.879,-1018.36;Inherit;False;Property;_noise_ST;_noise_ST;96;1;[HideInInspector];Create;True;0;0;0;False;0;False;1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;940;-7447,-2676;Inherit;False;1;564;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.MatrixFromVectors;877;-7056,-1264;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.FunctionNode;535;-6912,-1632;Inherit;False;Polar Coordinates;-1;;46;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;680;-7447,-2820;Inherit;False;0;564;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;939;-7360,-2530;Inherit;False;930;uv2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;865;-7200,-2320;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;941;-7072,-1536;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;867;-7488,-2144;Inherit;False;Constant;_Vector26;Vector 26;138;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector4Node;676;-7440,-1984;Inherit;False;Property;_noisemask_ST;_noisemask_ST;103;1;[HideInInspector];Create;True;0;0;0;False;0;False;1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;866;-7232,-2432;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;880;-6656,-1600;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.MatrixFromVectors;868;-7008,-2336;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.DynamicAppendNode;531;-6955.771,-886.0676;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;879;-6818.776,-1301.555;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;938;-7138,-2672;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;682;-6838.7,-2652.4;Inherit;False;Polar Coordinates;-1;;47;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;869;-6736,-2336;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;540;-6592,-954;Inherit;False;Property;_Float54;扰动极坐标（竖向贴图）;94;0;Create;False;0;0;0;False;1;SubToggle(g4, _);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;870;-6640,-2496;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;538;-6464,-1616;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;679;-6928,-1920;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;536;-6504.002,-1288.443;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;685;-6608,-1920;Inherit;False;Property;_Float57;扰动遮罩极坐标;101;0;Create;False;0;0;0;False;1;SubToggle(g4, _);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;683;-6562.586,-2156.872;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;694;-6480,-2512;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;393;-6320,-1136;Inherit;False;Property;_Float44;扰动贴图旋转;95;0;Create;False;0;0;0;False;1;Sub(g4);False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;530;-6976,-752;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;539;-6144,-1456;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;696;-6336,-2032;Inherit;False;Property;_Float74;扰动遮罩旋转;102;0;Create;False;0;0;0;False;1;Sub(g4);False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;687;-6896,-1824;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;688;-6176,-2352;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;53;-5856,-1424;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PiNode;394;-6048,-1248;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;695;-6064,-2144;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;395;-5648,-1392;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;697;-5872,-2320;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;638;-6016,-1104;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RotatorNode;698;-5664,-2288;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;643;-5568,-1504;Inherit;False;Property;_Float67;扰动贴图x轴Clamp;92;0;Create;False;0;0;0;True;1;SubToggle(g4, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;639;-5776,-1024;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;689;-6032,-2000;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ClampOpNode;640;-5744,-1184;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;779;-5584,-928;Inherit;False;Property;_Float85;扰动贴图y轴Clamp;93;0;Create;False;0;0;0;True;1;SubToggle(g4, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;817;-3436.151,-5587.112;Inherit;False;2519.616;1473.895;主贴图;26;439;802;801;798;796;803;799;804;431;39;42;433;795;60;793;59;443;43;806;449;446;445;444;440;36;161;主贴图;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector4Node;431;-2906.728,-4874.591;Inherit;False;Property;_maintex_ST;主贴图tilling&offset;38;1;[HideInInspector];Create;False;0;0;0;False;0;False;1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;692;-5760,-2064;Inherit;False;Property;_Float73;扰动遮罩x轴Clamp;99;0;Create;False;0;0;0;True;1;SubToggle(g4, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;777;-5808,-1680;Inherit;False;Property;_Float84;扰动遮罩y轴Clamp;100;0;Create;False;0;0;0;True;1;SubToggle(g4, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;690;-5728,-1984;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;1128;-2938.528,-6078.787;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;778;-5472,-1280;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;780;-5392,-1040;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;691;-5776,-1808;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;776;-5504,-1760;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;798;-3227.035,-5274.781;Inherit;False;Constant;_Float91;Float 91;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;512;-6792.832,4855.289;Inherit;False;2803.434;1805.293;Comment;35;499;502;57;506;509;510;507;500;511;501;58;92;314;317;302;304;306;307;309;303;738;737;807;808;809;810;811;812;813;814;815;816;951;952;953;溶解uv;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;641;-5296,-1328;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;775;-5456,-2112;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;439;-3316.591,-4580.434;Inherit;False;Property;_Vector0;主贴图流动&斜切;42;0;Create;False;0;0;0;False;1;Sub(g1);False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;1131;-2821.891,-5866.04;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;796;-3201.203,-5412.148;Inherit;False;Constant;_Float13;Float 13;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;801;-3269.093,-5029.263;Inherit;False;Constant;_Float93;Float 93;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;802;-3239.448,-5134.948;Inherit;False;Constant;_Float94;Float 94;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1130;-2724.223,-5692.827;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1132;-2686.065,-6064.699;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;50;-5184,-1648;Inherit;True;Property;_noise;扰动贴图;91;0;Create;False;0;0;0;False;1;Sub(g4);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;500;-6677.668,6140.592;Inherit;False;Property;_Vector15;溶解流动&斜切;77;0;Create;False;0;0;0;False;1;Sub(g3);False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;924;-5072,-1456;Inherit;False;Property;_Vector33;扰动贴图remap;105;0;Create;False;0;0;0;False;1;Sub(g4);False;0,1,0,1;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;807;-6743.606,5569.687;Inherit;False;Constant;_Float95;Float 95;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;809;-6724.894,5507.348;Inherit;False;Constant;_Float96;Float 96;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;808;-6711.585,5428.89;Inherit;False;Constant;_Float92;Float 92;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;814;-6639.229,5323.198;Inherit;False;Constant;_Float90;Float 90;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1134;-2401.689,-5860.368;Inherit;False;Property;_Float144;使用屏幕uv;31;0;Create;False;0;0;0;False;1;SubToggle(g1, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;804;-3263.981,-4906.542;Inherit;False;Constant;_Vector1;Vector 1;138;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;799;-2969.437,-5363.44;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;803;-2980.828,-5171.457;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;693;-5312,-1936;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;1133;-2516.062,-5977.973;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;35;-3018.212,-6276.304;Inherit;False;0;1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;39;-2776.327,-4415.217;Inherit;True;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;923;-4688,-1648;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1127;-2142.009,-5946.699;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;443;-2416.695,-5506.128;Inherit;False;Polar Coordinates;-1;;90;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;811;-6424.417,5497.431;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector4Node;499;-6723.704,5832.738;Inherit;False;Property;_dissolvetex_ST;_dissolvetex_ST;76;1;[HideInInspector];Create;True;0;0;0;False;0;False;1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;810;-6449.261,5362.322;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;564;-5136,-1984;Inherit;True;Property;_noisemask;扰动遮罩;98;0;Create;False;0;0;0;False;1;Sub(g4);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture1D;8;0;SAMPLER1D;;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;57;-6742.832,4934.997;Inherit;False;0;23;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;812;-6747.792,5652.854;Inherit;False;Constant;_Vector2;Vector 2;138;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;60;-2200.259,-4349.142;Inherit;False;Property;_Float10;custom1xy控制主贴图偏移;166;0;Create;False;0;0;0;True;1;SubToggle(g7, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;433;-2453.469,-4780.213;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;42;-2437.774,-4404.011;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.MatrixFromVectors;795;-2788.061,-5155.683;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;953;-6748.351,5075.834;Inherit;False;1;23;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;951;-6516.351,5212.834;Inherit;False;930;uv2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;506;-6112.226,4916.078;Inherit;False;Polar Coordinates;-1;;91;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;793;-2394.479,-5170.1;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;567;-4448,-1728;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;952;-6354.351,5042.834;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.MatrixFromVectors;813;-6228.453,5545.457;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.LerpOp;59;-2195.356,-4752.71;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;700;-4480,-1936;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;449;-2015.384,-5158.836;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;806;-2216.55,-5291.314;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;703;-4800,-1328;Inherit;False;Property;_Float76;扰动遮罩/双重扰动（勾上启用双重扰动）;90;0;Create;False;0;0;0;True;1;SubToggle(g4, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;731;-5040,-976;Inherit;False;Property;_Float79;溶解扰动强度;108;0;Create;False;0;0;0;False;1;Sub(g4);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;701;-4256,-1824;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;732;-4768,-976;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;-2009.519,-4887.891;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;502;-6319.718,6010.015;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;816;-5825.21,5030.48;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;446;-1884.304,-5308.937;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;445;-1920.803,-4811.658;Inherit;False;Property;_Float49;主贴图极坐标（竖向贴图）;36;0;Create;False;0;0;0;False;1;SubToggle(g1, _);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;815;-5994.219,5215.448;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;312;-4755.34,-2986.389;Inherit;False;1094.708;330.5801;flowmap;7;241;242;285;310;311;305;316;flowmap;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;509;-5664.252,5344.489;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;241;-4704,-2944;Inherit;True;Property;_flowmaptex;flowmaptex;110;0;Create;True;0;0;0;False;1;Sub(g14);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;733;-4448,-976;Inherit;False;noise_intensity_dis;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;70;-4176,-1584;Inherit;False;noise;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;305;-4157.694,-2851.015;Inherit;False;Property;_Float31;custom2y控制flowmap扭曲;170;0;Create;False;0;0;0;True;1;SubToggle(g7, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;310;-4160,-2752;Inherit;False;Property;_Float32;flowmap扰动;111;0;Create;False;0;0;0;False;1;Sub(g14);False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;510;-5781.266,5577.715;Inherit;False;Property;_Float53;溶解极坐标（竖向贴图）;74;0;Create;False;0;0;0;False;1;SubToggle(g3, _);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;440;-2423.611,-4581.301;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;507;-5575.584,4969.039;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;444;-1705.038,-5172.987;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;311;-3871.549,-2738.436;Inherit;False;flowmap_intensity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;302;-5550.425,5960.469;Inherit;False;733;noise_intensity_dis;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;242;-4384,-2912;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;511;-5343.67,5144.628;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;501;-6250.362,6175.074;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;316;-3887.81,-2853.027;Inherit;False;flpwmap_custom_switch;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;304;-5586.323,5829.766;Inherit;False;70;noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;36;-1485.97,-4852.907;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;58;-4995.538,5172.789;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;303;-5771.103,6358.585;Inherit;True;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;317;-5185.265,6377.987;Inherit;False;316;flpwmap_custom_switch;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;498;-7011.592,-5547.575;Inherit;False;3316.701;2494.345;Comment;82;478;74;73;75;481;483;486;474;77;217;477;469;471;491;497;479;496;468;472;321;323;484;494;322;485;495;467;480;79;390;216;387;319;388;320;391;392;389;408;405;218;8;406;407;220;82;620;622;623;624;625;626;616;769;770;771;772;774;773;818;819;820;821;822;823;824;825;826;827;830;835;834;833;836;837;828;931;932;933;934;935;936;Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;161;-1259.652,-4845.328;Inherit;False;maintexUV_00;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;738;-5186.708,5766.368;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1095;2269.664,-4069.198;Inherit;False;Property;_Float38;视差缩放;163;0;Create;False;0;0;0;False;1;Sub(g15);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;314;-5379.345,6230.5;Inherit;False;311;flowmap_intensity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;285;-4104.301,-2936.389;Inherit;False;flowmap;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;820;-6958.883,-5227.491;Inherit;False;Constant;_Float99;Float 99;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;828;-6999.883,-3777.416;Inherit;False;Constant;_Float101;Float 101;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;831;-6970.522,-3875.013;Inherit;False;Constant;_Float104;Float 104;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;821;-6994.715,-5063.575;Inherit;False;Constant;_Float100;Float 100;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;829;-6958.109,-4014.846;Inherit;False;Constant;_Float102;Float 102;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;819;-6970.603,-5133.207;Inherit;False;Constant;_Float98;Float 98;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;484;-6928,-3280;Inherit;False;Property;_Vector13;遮罩02流动&斜切;69;0;Create;False;0;0;0;False;1;Sub(g2);False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;307;-4934.778,6142.762;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;830;-6968.703,-4128.217;Inherit;False;Constant;_Float103;Float 103;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;278;-3229.496,771.2501;Inherit;False;2403.086;1048.659;溶解方向+开洞l;17;277;412;415;416;417;418;568;571;954;955;956;1027;1035;1015;1017;1057;1059;溶解方向+开洞;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-5056,-1184;Inherit;False;Property;_Float9;主贴图扰动强度;106;0;Create;False;0;0;0;False;1;Sub(g4);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;479;-6983.609,-4667.555;Inherit;False;Property;_Vector11;遮罩01流动速度&斜切;61;0;Create;False;0;0;0;False;1;Sub(g2);False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;1096;2253.159,-3968.228;Inherit;False;Tangent;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;1121;2206.281,-4438.95;Inherit;False;161;maintexUV_00;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;818;-7000.641,-4975.674;Inherit;False;Constant;_Float97;Float 97;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1103;2536.405,-4152.16;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1104;2578.624,-3946.621;Inherit;False;Property;_refplane;refplane(0黑色下沉,1白色抬高);164;0;Create;False;0;0;0;False;1;Sub(g15);False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;737;-4924.859,5683.832;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;306;-5230.016,6042.288;Inherit;False;285;flowmap;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;1094;2220.387,-4277.181;Inherit;True;Property;_parallax;视差贴图;162;0;Create;False;0;0;0;False;1;Sub(g15);False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.CommentaryNode;636;-3862.247,-1551.912;Inherit;False;2648.927;985.3096;Comment;40;385;386;635;633;632;634;631;29;281;49;23;25;62;31;24;30;26;33;45;34;32;122;61;384;93;661;784;785;786;912;913;914;915;916;918;1060;1062;1089;1090;1091;软溶解;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;954;-3052.77,1231.643;Inherit;False;930;uv2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;936;-6989.049,-4266.879;Inherit;False;1;218;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;77;-6986.136,-5532.217;Inherit;False;0;8;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;483;-6991.586,-3518.17;Inherit;False;Property;_Mask1_ST;_Mask1_ST;68;1;[HideInInspector];Create;True;0;0;0;False;0;False;1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;833;-6765.604,-4094.595;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;956;-3195.492,1081.38;Inherit;False;1;412;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;822;-6956.994,-4859.457;Inherit;False;Constant;_Vector3;Vector 3;138;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DynamicAppendNode;834;-6736.532,-3898.222;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;309;-4754.008,5797.791;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;418;-3198.437,915.9819;Inherit;False;0;412;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;824;-6633.684,-5178.038;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;823;-6625.031,-5318.283;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;935;-6793.533,-4185.381;Inherit;False;930;uv2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;933;-6830.65,-5338.782;Inherit;False;930;uv2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;74;-6707.094,-4562.272;Inherit;True;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;478;-6622.95,-5001.858;Inherit;False;Property;_Mask_ST;_Mask_ST;60;1;[HideInInspector];Create;True;0;0;0;False;0;False;1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;832;-7014.055,-3695.607;Inherit;False;Constant;_Vector4;Vector 4;138;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ParallaxOcclusionMappingNode;1092;2760.571,-4285.335;Inherit;False;0;128;False;-1;128;False;-1;10;0.02;1;False;1,1;False;0,0;8;0;FLOAT2;0,0;False;1;SAMPLER2D;;False;7;SAMPLERSTATE;;False;2;FLOAT;0.02;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT2;0,0;False;6;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;360;-4800,-1200;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;932;-7012.682,-5407.778;Inherit;False;1;8;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;217;-6970.399,-4404.645;Inherit;False;0;218;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;734;-5040,-1072;Inherit;False;Property;_Float80;mask扰动强度;107;0;Create;False;0;0;0;False;1;Sub(g4);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.MatrixFromVectors;825;-6472.706,-5224.272;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.LerpOp;931;-6622.682,-5476.778;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;75;-6387.791,-4521.63;Inherit;True;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-6053.1,-4481.973;Inherit;False;Property;_Float12;custom1zw控制mask01偏移;167;0;Create;False;0;0;0;True;1;SubToggle(g7, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;92;-4213.401,5212.188;Inherit;False;dissolveUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;497;-6209.446,-4202.971;Inherit;False;Polar Coordinates;-1;;98;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;477;-6130.515,-5509.042;Inherit;False;Polar Coordinates;-1;;99;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;67;-4512,-1216;Inherit;False;noise_intensity_main;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1097;3045.011,-4262.341;Inherit;False;parallax;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;384;-3836.248,-1350.417;Inherit;False;Property;_Float41;溶解贴图旋转;75;0;Create;False;0;0;0;False;1;Sub(g3);False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.MatrixFromVectors;835;-6594.048,-3903.101;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.LerpOp;934;-6594.565,-4286.377;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;955;-2860.77,1119.643;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;481;-6304,-4848;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;93;-3639.004,-1501.912;Inherit;False;92;dissolveUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;486;-6540,-3344.619;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;474;-6037.164,-4863.898;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;415;-2882.005,1502.212;Inherit;False;Property;_Float47;溶解方向旋转;79;0;Create;False;0;0;0;False;1;Sub(g3);False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;730;-8714.083,633.6453;Inherit;False;3930.691;2494.765;顶点偏移;84;706;544;707;173;710;546;551;711;712;549;714;555;716;715;554;552;728;718;719;556;557;396;168;729;397;725;398;726;644;720;721;722;645;646;649;647;723;727;178;167;179;705;169;176;175;172;171;181;787;788;789;790;791;792;881;882;883;884;885;886;887;888;889;890;891;892;893;894;895;896;897;898;899;921;922;945;946;947;948;949;950;990;993;994;顶点偏移;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;735;-4768,-1104;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;385;-3549.538,-1253.424;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;827;-5865.49,-5417.849;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;837;-6078.913,-3944.78;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;836;-6430.828,-4089.915;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;826;-6298.804,-5417.229;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1100;-1185.658,-2251.331;Inherit;False;1097;parallax;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1101;-1323.983,-2172.848;Inherit;False;Property;_Float143;开启视差映射(mesh模式下使用）;161;0;Create;False;0;0;0;False;1;SubToggle(g15, _);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;71;-1075.102,-2057.324;Inherit;False;70;noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;162;-1107.667,-2337.14;Inherit;False;161;maintexUV_00;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;571;-2718.695,837.3738;Inherit;False;Polar Coordinates;-1;;93;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;471;-5925.974,-5295.075;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;72;-1073.282,-1921.849;Inherit;False;67;noise_intensity_main;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;468;-5709.996,-4949.717;Inherit;False;Property;_Float51;遮罩01极坐标（竖向贴图）;58;0;Create;False;0;0;0;False;1;SubToggle(g2, _);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;472;-5685.974,-5455.075;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;736;-4480,-1120;Inherit;False;noise_intensity_mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;386;-3405.465,-1421.732;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;318;-729.1737,-1622.387;Inherit;False;316;flpwmap_custom_switch;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;491;-6054.449,-3572.763;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;496;-5934.142,-3907.305;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;494;-5987.206,-3319.945;Inherit;False;Property;_Float52;遮罩02极坐标（竖向贴图）;66;0;Create;False;0;0;0;False;1;SubToggle(g2, _);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;1015;-2091.07,1318.631;Inherit;False;Property;_Vector35;开洞坐标;87;0;Create;False;0;0;0;False;1;Sub(g3);False;0,0,0,0;-0.15,1.8,-0.41,0.4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;891;-8697.299,1927.639;Inherit;False;Constant;_Float122;Float 122;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;890;-8707.965,1870.067;Inherit;False;Constant;_Float121;Float 121;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;555;-8581.451,2680.061;Inherit;False;Property;_Vector19;顶点偏移流动&斜切;121;0;Create;False;0;0;0;False;1;Sub(g5);False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;1099;-823.6074,-2261.364;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;353;-859.7374,-2040.468;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;893;-8706.43,2097.995;Inherit;False;Constant;_Float124;Float 124;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;100;-989.5694,-1730.834;Inherit;False;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;313;-756.0134,-1774.17;Inherit;False;311;flowmap_intensity;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;416;-2481.635,1519.068;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;568;-2349.976,1020.234;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;469;-5867.276,-5028.779;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;892;-8684.934,2006.185;Inherit;False;Constant;_Float123;Float 123;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;897;-8431.951,1999.968;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;321;-5456.687,-3892.311;Inherit;False;70;noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1017;-1857.47,1352.049;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;635;-3323.935,-1293.86;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RotatorNode;417;-2125.709,1018.199;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;485;-6531.846,-3217.787;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;480;-6304,-4736;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;895;-8449.609,1893.482;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;894;-8706.748,2178.215;Inherit;False;Constant;_Vector29;Vector 29;138;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;495;-5651.359,-3604.686;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1027;-2021.855,1539.836;Inherit;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;467;-5403.192,-5152.456;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;354;-588.8185,-2078.095;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;380;-783.4704,-2395.421;Inherit;False;Property;_Float39;主贴图旋转;37;0;Create;False;0;0;0;False;1;Sub(g1);False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;284;-607.7364,-1857.25;Inherit;False;285;flowmap;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;948;-8467.366,1845.149;Inherit;False;930;uv2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;99;-457.5145,-1757.622;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;323;-5520.148,-3768.018;Inherit;False;736;noise_intensity_mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;173;-8633.986,1655.241;Inherit;False;0;169;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;950;-8627.366,1765.149;Inherit;False;1;169;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;322;-5180.346,-3817.024;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;544;-8685.137,2405.465;Inherit;False;Property;_vertextex_ST;_vertextex_ST;120;1;[HideInInspector];Create;True;0;0;0;False;0;False;1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;79;-5052.572,-5043.696;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;882;-8678.968,926.0474;Inherit;False;Constant;_Float118;Float 118;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1059;-1673.63,1619.744;Inherit;False;Property;_Float139;开洞（开启后方向失效）;86;0;Create;False;0;0;0;True;1;SubToggle(g3, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;412;-1888.86,987.1398;Inherit;True;Property;_TextureSample0;溶解方向贴图（渐变）;78;0;Create;False;0;0;0;False;1;Ramp(g3);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture1D;8;0;SAMPLER1D;;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;387;-5172.797,-3638.586;Inherit;False;Property;_Float42;遮罩02旋转;67;0;Create;False;0;0;0;False;1;Sub(g2);False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;633;-3116.146,-1221.938;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;785;-3257.257,-1093.851;Inherit;False;Property;_Float87;溶解贴图y轴Clamp;73;0;Create;False;0;0;0;True;1;SubToggle(g3, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;1035;-1676.739,1356.925;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;216;-5287.117,-3556.391;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;884;-8688.097,1096.403;Inherit;False;Constant;_Float120;Float 120;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;883;-8666.603,1004.593;Inherit;False;Constant;_Float119;Float 119;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;949;-8275.366,1733.149;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;390;-5236.398,-4824.823;Inherit;False;Property;_Float43;遮罩01旋转;59;0;Create;False;0;0;0;False;1;Sub(g2);False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;716;-8466.573,1474.328;Inherit;False;Property;_Vector25;顶点偏移遮罩流动＆斜切;129;0;Create;False;0;0;0;False;1;Sub(g5);False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PiNode;378;-453.148,-2367.565;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.MatrixFromVectors;896;-8274.712,2091.249;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.ClampOpNode;632;-3139.666,-1342.1;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;881;-8689.632,868.4754;Inherit;False;Constant;_Float117;Float 117;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;634;-3115.571,-1462.119;Inherit;False;Property;_Float66;溶解贴图x轴Clamp;72;0;Create;False;0;0;0;True;1;SubToggle(g3, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;283;-251.856,-2030.864;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;898;-7913.26,2041.444;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;706;-8520.824,1235.588;Inherit;False;Property;_vertextex1_ST;_vertextex1_ST;128;1;[HideInInspector];Create;True;0;0;0;False;0;False;1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PiNode;388;-5268.476,-3642.73;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;391;-4952.867,-4744.793;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;886;-8391.942,873.0101;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;947;-8522.157,762.2756;Inherit;False;1;705;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;784;-2848.75,-1413.345;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;549;-7961.628,1766.015;Inherit;False;Polar Coordinates;-1;;100;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;918;-2729.641,-1519.255;Inherit;False;Property;_Float130;混合溶解强度;80;0;Create;False;0;0;0;False;1;Sub(g3);False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;319;-5024.052,-4601.649;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;885;-8688.416,1176.623;Inherit;False;Constant;_Vector28;Vector 28;138;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;707;-8518.483,633.5099;Inherit;False;0;705;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;786;-2878.257,-1206.851;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;945;-8362.157,842.2756;Inherit;False;930;uv2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;888;-8413.619,998.3764;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RotatorNode;377;-200.568,-2397.748;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;320;-4856.229,-3799.028;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;1057;-1280.282,1172.057;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-3057.609,-1026.478;Inherit;False;Property;_Float6;溶解;81;0;Create;False;0;0;0;False;1;Sub(g3);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;631;-2678.902,-1275.116;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;1062;-2493.754,-1455.786;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;946;-8170.157,730.2756;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;900;-7642.331,1881.517;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;146;-3141.72,3013.755;Inherit;False;1475.065;723.4756;菲尼尔;11;135;137;138;139;140;141;142;144;147;136;352;菲尼尔;1,1,1,1;0;0
Node;AmplifyShaderEditor.RotatorNode;389;-4786.38,-3667.767;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;546;-8207.091,2615.418;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;603;-45.6499,-2278.642;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.FunctionNode;712;-7832.597,680.8583;Inherit;False;Polar Coordinates;-1;;101;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;49;-3292.072,-943.5662;Inherit;False;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;277;-1203.46,1026.492;Inherit;False;dis_direction;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.MatrixFromVectors;887;-8223.322,956.2864;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.VertexColorNode;912;-2953.565,-840.4972;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;61;-3140.247,-760.6021;Inherit;False;Property;_Float11;custom2x控制溶解;168;0;Create;False;0;0;0;False;1;SubToggle(g7, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;392;-4771.551,-4688.157;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;617;-5164.772,-4251.176;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.OneMinusNode;915;-2758.661,-830.8226;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;623;-5246.948,-3303.893;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DynamicAppendNode;710;-7982.148,1414.472;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldNormalVector;136;-3118.165,3057.115;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;281;-2568.437,-1347.768;Inherit;False;277;dis_direction;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;889;-7978.904,838.1533;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;552;-7757.952,2678.026;Inherit;False;Property;_Float56;顶点偏移极坐标（竖向贴图）;118;0;Create;False;0;0;0;False;1;SubToggle(g5, _);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;554;-7599.292,2049.103;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;605;133.9357,-2175.883;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;62;-2740.221,-984.6865;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;608;-64.82919,-2507.837;Inherit;False;Property;_Float62;主贴图x轴clamp;34;0;Create;False;0;0;0;True;1;SubToggle(g1, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-2540.615,-1253.993;Inherit;True;Property;_dissolvetex;溶解贴图;71;0;Create;False;0;0;0;False;1;Sub(g3);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;899;-7603.787,803.4982;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;1060;-2272.3,-1511.706;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FaceVariableNode;352;-3012.43,3187.22;Inherit;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;758;-7016.301,-395.5196;Inherit;False;1519.266;836.9044;软粒子;15;96;98;327;333;334;337;97;126;752;756;753;757;336;754;755;软粒子;1,1,1,1;0;0
Node;AmplifyShaderEditor.ClampOpNode;604;203.9973,-2320.943;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;763;25.01416,-2045.606;Inherit;False;Property;_Float71;主贴图y轴clamp;35;0;Create;False;0;0;0;True;1;SubToggle(g1, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;914;-2776.012,-687.4841;Inherit;False;Property;_Float129;粒子alpha控制溶解（溶解拖尾使用）;169;0;Create;False;0;0;0;False;1;SubToggle(g7, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;551;-7817.1,2444.744;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;620;-5005.937,-4399.004;Inherit;False;Property;_Float64;遮罩01x轴Clamp;56;0;Create;False;0;0;0;True;1;SubToggle(g2, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;913;-2478.706,-938.4984;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;333;-6745.693,325.3848;Inherit;False;Property;_Float5;反向软粒子(强化边缘）;18;0;Create;False;0;0;0;True;1;SubToggle(g9, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;624;-5062.679,-3354.133;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;138;-3076.711,3573.226;Inherit;False;Property;_Float19;菲尼尔软硬;28;0;Create;False;0;0;0;False;1;Sub(g8);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;351;-2795.43,3144.22;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;626;-5040,-3504;Inherit;False;Property;_Float65;遮罩02x轴Clamp;64;0;Create;False;0;0;0;True;1;SubToggle(g2, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;770;-4993.379,-4019.428;Inherit;False;Property;_Float82;遮罩01y轴Clamp;57;0;Create;False;0;0;0;True;1;SubToggle(g2, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;96;-6851.671,253.7125;Inherit;False;Property;_Float16;软粒子（羽化边缘）;17;0;Create;False;0;0;0;False;1;Sub(g9);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-2218.638,-918.5462;Inherit;False;Constant;_Float3;Float 3;11;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;135;-3045.824,3462.564;Inherit;False;Property;_power3;菲尼尔范围;26;0;Create;False;0;0;0;False;1;Sub(g8);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;711;-7635.226,1120.972;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;625;-5067.159,-3221.971;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2057.78,-886.6257;Inherit;False;Constant;_Float7;Float 7;11;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;715;-7421.063,733.3063;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;396;-7422.272,2480.826;Inherit;False;Property;_Float45;顶点贴图旋转;119;0;Create;False;0;0;0;False;1;Sub(g5);False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;557;-8191.453,2741.061;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;556;-7324.799,2186.685;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PosVertexDataNode;98;-6836.29,91.33076;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;618;-4980.503,-4301.416;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;137;-3052.719,3270.273;Inherit;False;World;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;607;324.8375,-2456.35;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;714;-7577.378,1355.553;Inherit;False;Property;_Float75;顶点偏移遮罩极坐标;126;0;Create;False;0;0;0;False;1;SubToggle(g5, _);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;619;-4984.984,-4169.254;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;916;-2207.583,-1346.964;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;774;-4936.102,-3140.36;Inherit;False;Property;_Float83;遮罩02y轴Clamp;65;0;Create;False;0;0;0;True;1;SubToggle(g2, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;764;318.0142,-2194.606;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1091;-1990.488,-651.1614;Inherit;False;Property;_Float142;custom2z控制溶解软硬;171;0;Create;False;0;0;0;True;1;SubToggle(g7, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;753;-6951.867,-80.19434;Inherit;False;Property;_Float0;相机软粒子（贴脸羽化）位置;22;0;Create;False;0;0;0;False;1;Sub(g9);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;773;-4737.102,-3251.36;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;168;-7070.666,2215.753;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;719;-7945.774,1552.875;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;771;-4683.732,-4071.075;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;752;-6964.098,-345.5196;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PiNode;397;-7252.301,2544.294;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;139;-2742.485,3325.885;Inherit;False;Standard;WorldNormal;ViewDir;True;True;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;97;-6604.836,90.75565;Inherit;False;True;True;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-2125.247,-812.408;Inherit;False;Property;_Float8;软硬;82;0;Create;False;0;0;0;False;1;Sub(g3);False;0.5;1;0;0.5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1089;-2246.936,-749.8066;Inherit;False;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;334;-6483.376,320.6759;Inherit;False;depthfade_switch;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;24;-2009.659,-1151.568;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;772;-4800,-3424;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;114;-3227.833,-169.203;Inherit;False;1936.036;770.2162; 亮边溶解;9;107;109;105;106;108;124;130;133;1053;亮边溶解;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;769;-4761.483,-4387.489;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;606;478.5153,-2343.192;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;756;-6966.301,-175.2479;Inherit;False;Property;_Float55;相机软粒子（贴脸羽化）距离;21;0;Create;False;0;0;0;False;1;Sub(g9);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;661;-1750.088,-1459.638;Inherit;False;dis_tex;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-1905.329,-1075.194;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;728;-7142.924,862.9124;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;718;-7409.397,1203.054;Inherit;False;Property;_Float77;顶点遮罩旋转;127;0;Create;False;0;0;0;False;1;Sub(g5);False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;140;-2505.02,3326.082;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1090;-1780.781,-791.825;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1053;-2731.736,-36.27806;Inherit;False;661;dis_tex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;337;-6259.045,305.1179;Inherit;False;334;depthfade_switch;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CameraDepthFade;754;-6607.409,-272.9024;Inherit;False;3;2;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;327;-6383.158,172.6414;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;398;-6992.47,2384.011;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;1;622.7107,-2232.574;Inherit;True;Property;_maintex;主贴图;32;0;Create;False;0;0;0;False;1;Sub(g1);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-1797.278,-1230.717;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;403;628.6151,-1984.579;Inherit;False;Property;_maintex_alpha;主贴图通道切换（默认A，勾上R）;33;0;Create;False;0;0;0;False;1;SubToggle(g1, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;729;-7070.427,1220.521;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;622;-4619.498,-3376.833;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;616;-4625.501,-4236.024;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;725;-6901.163,887.341;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SaturateNode;45;-1596.557,-1204.824;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;218;-4446.376,-3619.329;Inherit;True;Property;_Mask1;遮罩02;62;0;Create;False;0;0;0;False;1;Sub(g2);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotatorNode;726;-6810.596,1060.239;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;336;-6100.238,75.26977;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;34;-1567.559,-752.6214;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;408;-4254.527,-3393.536;Inherit;False;Property;_mask02_alpha;遮罩02通道切换（默认A，勾上R）;63;0;Create;False;0;0;0;False;1;SubToggle(g2, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;142;-2560.026,3560.687;Inherit;False;Property;_Float20;反向菲尼尔（虚化边缘）;29;0;Create;False;0;0;0;True;1;SubToggle(g8, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;130;-2457.58,-35.28879;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-0.5;False;2;FLOAT;1.5;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;755;-6313.52,-267.9716;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;141;-2409.202,3428.264;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;405;-4474.457,-3882.028;Inherit;False;Property;_mask01_alpha;遮罩01通道切换（默认A，勾上R）;55;0;Create;False;0;0;0;False;1;SubToggle(g2, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;8;-4431.885,-4113.886;Inherit;True;Property;_Mask;遮罩01;54;0;Create;False;0;0;0;False;1;Sub(g2);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;402;980.7657,-2117.516;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;644;-7470.53,2730.82;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.AbsOpNode;1199;1046.098,-1915.69;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;792;-7124.727,3010.527;Inherit;False;Property;_Float89;顶点偏移贴图y轴Clamp;117;0;Create;False;0;0;0;True;1;SubToggle(g5, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;144;-2176.633,3335.982;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;406;-4062.611,-4056.421;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;646;-7236.695,2773.42;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;720;-7275.088,1513.887;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;757;-5952.993,-148.1963;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;105;-2140.847,-98.51211;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;32;-1477.139,-1087.975;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;649;-7337.818,2667.41;Inherit;False;Property;_Float68;顶点偏移贴图x轴Clamp;116;0;Create;False;0;0;0;True;1;SubToggle(g5, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;365;720.6054,-1830.794;Inherit;False;Property;_Float34;主贴图细节对比度;39;0;Create;False;0;0;0;False;1;Sub(g1);False;1;4.74;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;407;-4010.675,-3616.126;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;645;-7277.174,2921.583;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;372;1173.36,-1803.603;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;727;-6902.836,1372.223;Inherit;False;Property;_Float78;顶点偏移遮罩x轴Clamp;124;0;Create;False;0;0;0;True;1;SubToggle(g5, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;122;-1409.935,-848.9914;Inherit;False;dis_soft;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;790;-7037.636,2635.646;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;370;723.0806,-1733.819;Inherit;False;Property;_Float37;主贴图细节提亮;40;0;Create;False;0;0;0;False;1;Sub(g1);False;1;6.18;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;722;-6966.713,1728.636;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;147;-1878.385,3301.25;Inherit;False;fresnel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;126;-5721.036,65.64495;Inherit;False;depthfade;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;721;-6959.221,1543.474;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;124;-1800.693,-109.7006;Inherit;False;dis_bright;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;220;-4120.95,-3831.159;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;791;-6944.545,2871.763;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;788;-6926.462,1866.367;Inherit;False;Property;_Float88;顶点偏移遮罩y轴Clamp;125;0;Create;False;0;0;0;True;1;SubToggle(g5, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;647;-6801.513,2590.72;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;82;-3918.89,-3831.313;Inherit;False;Mask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;125;145.3781,-127.8404;Inherit;False;124;dis_bright;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;367;699.2643,-1624.499;Inherit;False;Property;_Float36;细节平滑过渡;41;0;Create;False;0;0;0;False;1;Sub(g1);False;1;0.903;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;787;-6626.899,1464.961;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;350;1028.062,-346.0324;Inherit;False;Property;_Float33;单独菲尼尔开关;24;0;Create;False;0;0;0;False;1;SubToggle(g8, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;123;137.3978,-211.4309;Inherit;False;122;dis_soft;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;789;-6633.962,1793.554;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;209;868.8461,-518.2598;Inherit;False;Constant;_Float27;Float 27;43;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;340;1301.027,256.3226;Inherit;False;334;depthfade_switch;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;373;1337.596,-1681.469;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;150;874.6943,-441.6401;Inherit;False;147;fresnel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;414;104.0469,32.22958;Inherit;False;Property;_Float25;亮边溶解（默认关闭，勾上开启）;83;0;Create;False;0;0;0;True;1;SubToggle(g3, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;128;1332.733,51.57904;Inherit;False;126;depthfade;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;374;1521.44,-1640.934;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;95;1801.246,-18.55526;Inherit;False;Property;_Float15;alpha强度;14;0;Create;False;0;0;0;False;1;Sub(g10);False;1;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;221;1767.981,217.0276;Inherit;False;82;Mask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;167;-6594.58,2699.5;Inherit;True;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalVertexDataNode;172;-6082.893,2199.664;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;413;572.2303,-168.7144;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;994;-6081.09,2349.731;Inherit;False;Constant;_Float136;Float 136;151;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;179;-6505.771,3000.662;Inherit;False;Property;_Float22;custom2w控制顶点偏移强度;173;0;Create;False;0;0;0;False;1;SubToggle(g7, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;338;1718.498,82.17676;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;990;-6065.756,2457.289;Inherit;False;Property;_Float135;顶点法线;113;0;Create;False;0;0;0;True;1;SubToggle(g5, _);False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;4;167.422,-922.795;Inherit;False;Property;_Color0;颜色;10;1;[HDR];Create;False;0;0;0;False;1;Sub(g10);False;1,1,1,1;0,0.6419505,2.270603,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;169;-6513.891,2001.706;Inherit;True;Property;_vertextex;顶点偏移贴图;114;0;Create;False;0;0;0;False;1;Sub(g5);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;723;-6464.121,1596.634;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector4Node;922;-6311.267,2194.702;Inherit;False;Property;_Vector32;顶点偏移贴图remap;115;0;Create;False;0;0;0;False;1;Sub(g5);False;0,1,0,1;0,1,0,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;178;-6306.146,2674.208;Inherit;False;Constant;_Float21;Float 21;37;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;3;313.8168,-1184.052;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;347;1417.91,-554.7366;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;921;-5983.323,2018.482;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;176;-5977.17,2740.609;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;705;-6324.812,1746.057;Inherit;True;Property;_vertextex1;顶点偏移遮罩;123;0;Create;False;0;0;0;False;1;Sub(g5);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;993;-5799.169,2186.453;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector3Node;175;-6037.788,2568.436;Inherit;False;Property;_Vector5;顶点偏移xyz强度;122;0;Create;False;0;0;0;False;1;Sub(g5);False;0,0,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;2431.051,-273.4656;Inherit;False;8;8;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;171;-5495.304,1970.702;Inherit;False;5;5;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;657;2660.212,-127.3093;Inherit;False;Property;_Float70;限制alpha值为0-1;15;0;Create;False;0;0;0;True;1;SubToggle(g10, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;602;2682.383,-313.9317;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1014;-536.2126,-5456.463;Inherit;False;1734.734;1247.487;假光照;25;995;1000;996;997;1013;1012;1002;1001;1007;958;957;1009;960;1011;959;1008;962;961;963;964;965;968;971;1147;1149;假光照;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;672;2917.155,-199.7776;Inherit;False;661;dis_tex;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;856;-3364.765,-3725.929;Inherit;False;2282.703;1348.265;ramptex;26;849;848;847;846;850;852;851;853;459;226;460;456;457;854;455;454;855;458;463;452;461;453;464;451;229;231;ramptex;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;181;-5004.712,2097.153;Inherit;False;vertexoffset;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;1075;1475.43,-5400.841;Inherit;False;2217.259;601.832;matcap;12;1064;1065;1066;1067;1068;1069;1070;1071;1063;1073;1072;1074;matcap;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;673;2869.026,-83.7159;Inherit;False;Property;_Float72;alphaclip溶解（层级2000以下使用）;88;0;Create;False;0;0;0;False;1;Sub(g3);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;588;-3244.336,1907.054;Inherit;False;3124.205;1004.605;Comment;43;194;193;201;188;191;190;202;185;183;196;576;580;582;584;585;579;186;195;192;575;581;586;589;590;591;650;651;652;653;655;781;782;783;901;902;903;904;905;906;907;908;909;910;折射;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;656;2920.57,-401.8413;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;847;-3229.639,-3358.295;Inherit;False;Constant;_Float106;Float 106;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1187;1948.576,-6367.044;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;599;1334.414,-2044.998;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;901;-3188.09,2040.586;Inherit;False;Constant;_Float125;Float 125;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;651;-1639.822,2042.254;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;422;2963.669,-1009.611;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;586;-2330.196,2627.662;Inherit;False;Property;_Float58;折射极坐标（竖向贴图）;135;0;Create;False;0;0;0;False;1;SubToggle(g6, _);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;589;-1479.219,2228.388;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;1174;-514.5505,-6109.532;Inherit;False;Constant;_Vector8;Vector 8;138;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector3Node;850;-3275.955,-2999.158;Inherit;False;Constant;_Vector6;Vector 6;138;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.Vector4Node;575;-3206.392,2529.498;Inherit;False;Property;_reftex_ST;_reftex_ST;137;1;[HideInInspector];Create;True;0;0;0;False;0;False;1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;655;-1482.538,2038.624;Inherit;False;Property;_Float69;折射贴图x轴Clamp;133;0;Create;False;0;0;0;True;1;SubToggle(g6, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1007;944.522,-4778.289;Inherit;False;pointlight;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;1188;1638.032,-5875.146;Inherit;False;Constant;_Vector14;Vector 14;138;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;848;-3171.032,-3485.935;Inherit;False;Constant;_Float107;Float 107;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;652;-1631.342,1933.092;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;346;1493.928,-2353.761;Inherit;False;Property;_Float30;边缘收窄;20;0;Create;False;0;0;0;False;1;Sub(g9);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1173;-215.3965,-6409.447;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;343;1428.612,-2771.807;Inherit;False;Property;_Float28;边缘强度;19;0;Create;False;0;0;0;False;1;Sub(g9);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;358;307.5624,-430.5294;Inherit;False;Property;_Float35;双面颜色（默认关闭，勾上开启）;12;0;Create;False;0;0;0;True;1;SubToggle(g10, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;846;-3269.412,-3123.404;Inherit;False;Constant;_Float105;Float 105;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;107;-2343.284,189.6209;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;193;-1364.284,2656.537;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1068;2632.209,-5270.241;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;852;-3014.983,-3255.047;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1176;267.3375,-6199.29;Inherit;False;2;2;0;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;194;-1854.385,2530.938;Inherit;True;2;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.MatrixFromVectors;1189;2129.952,-6159.286;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;582;-2389.344,2394.38;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.MatrixFromVectors;1175;-22.63062,-6393.672;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;584;-2171.536,1998.739;Inherit;False;3;0;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;1,1;False;2;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;910;-2312.665,1978.759;Inherit;False;2;2;0;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.DynamicAppendNode;579;-2779.336,2565.054;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RotatorNode;383;-239.743,-1421.919;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;231;-1306.062,-3047.576;Inherit;False;Gradienttex;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;1186;1937.186,-6175.061;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldPosInputsNode;1002;274.7202,-4585.094;Inherit;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;192;-1585.979,2465.205;Inherit;False;Property;_Float23;折射强度;140;0;Create;False;0;0;0;False;1;Sub(g6);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;235;-406.7563,-1214.137;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;1067;2480.081,-5361.748;Inherit;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PiNode;382;-471.7652,-1367.136;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1142;622.7408,-826.2454;Inherit;False;Property;_Color6;菲尼尔颜色;27;1;[HDR];Create;False;0;0;0;False;1;Sub(g8);False;1,1,1,1;0,0.6419505,2.270603,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ViewMatrixNode;1065;2192.244,-5318.869;Inherit;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.LerpOp;585;-1942.312,2106.268;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;598;-8080.473,-1473.006;Inherit;False;Property;_Float60;colormask;4;1;[Enum];Create;False;0;0;1;UnityEngine.Rendering.ColorWriteMask;True;0;False;15;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;609;-58.68368,-1565.849;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleSubtractOpNode;108;-1873.772,91.62876;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1192;2419.92,-5964.904;Inherit;False;2;2;0;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;229;-1498.935,-3046.488;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1136;661.5511,-572.6855;Inherit;False;147;fresnel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;186;-3139.38,1953.014;Inherit;False;0;190;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;1179;-143.1956,-6105.099;Inherit;False;0;1147;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;996;-72.58849,-4908.143;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1008;493.1096,-5348.277;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;212;593.9272,-1530.928;Inherit;True;Property;_Gradienttex;混合颜色贴图;44;0;Create;False;0;0;0;False;1;Ramp(g11);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;1178;104.7235,-5916.098;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;345;1679.021,-2492.01;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;464;-2292.159,-2553.768;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;961;585.8949,-5173.336;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1011;170.3177,-5000.183;Inherit;False;Property;_Float137;切换为假点光（默认为平行光）;150;0;Create;False;0;0;0;True;1;SubToggle(g12, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;213;658.145,-1232.839;Inherit;False;Property;_Float29;颜色混合（lerp模式）;52;0;Create;False;0;0;0;False;1;Sub(g11);False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;458;-2264.886,-2811.176;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;855;-2188.006,-3362.838;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;963;634.283,-5333.397;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;451;-1729.025,-3108.424;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;454;-2340.95,-2994.7;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;330;1483.579,-2534.84;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;457;-2516.021,-2777.428;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;461;-1991.686,-3258.543;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;1,1;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;902;-3177.425,2098.158;Inherit;False;Constant;_Float126;Float 126;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;460;-2413.342,-3578.787;Inherit;False;Polar Coordinates;-1;;92;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;782;-1331.228,2109.378;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;359;460.822,-850.4652;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;650;-1819.611,1958.332;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LerpOp;781;-1290.998,1938.46;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;421;-8392.288,-1444.528;Inherit;False;Property;_Ref_Group;折射;130;0;Create;False;0;0;0;False;1;Main(g6);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;960;421.9652,-5415.261;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;456;-2515.028,-2919.449;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;109;-2766.307,192.4556;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;455;-2536.359,-3048.364;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;766;-88.26966,-1298.326;Inherit;False;Property;_Float81;颜色混合贴图y轴Clamp;46;0;Create;False;0;0;0;True;1;SubToggle(g11, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;452;-2071.947,-2778.407;Inherit;False;Property;_Float50;颜色混合图极坐标（竖向贴图）;47;0;Create;False;0;0;0;False;1;SubToggle(g11, _);False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;463;-3268.197,-2600.012;Inherit;False;Property;_Vector7;颜色图流动速度;50;0;Create;False;0;0;0;False;1;Sub(g11);False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;854;-2583.405,-3410.126;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;962;471.0158,-5029.591;Inherit;False;Property;_Float133;阴影软硬;146;0;Create;False;0;0;0;False;1;Sub(g12);False;0.5;0.5;0.5;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwitchByFaceNode;356;594.5223,-986.8137;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;849;-3250.307,-3221.214;Inherit;False;Constant;_Float108;Float 108;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;211;1309.983,-2228.117;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector4Node;459;-2998.292,-2842.674;Inherit;False;Property;_Vector9;颜色混合图tilling&offset;49;0;Create;False;0;0;0;False;1;Sub(g11);False;1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;851;-2954.724,-3437.085;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;226;-3114.721,-3675.929;Inherit;False;0;212;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1066;2423.863,-5245.307;Inherit;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;958;51.88074,-5422.097;Inherit;False;False;1;0;FLOAT;0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;959;411.5947,-5187.137;Inherit;False;Property;_Float132;阴影范围;147;0;Create;False;0;0;0;False;1;Sub(g12);False;0.5;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;768;457.2302,-1541.226;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ScaleAndOffsetNode;453;-2109.892,-2994.504;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.MatrixFromVectors;853;-2773.873,-3281.284;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.WorldNormalVector;957;214.1247,-5301.764;Inherit;False;True;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.MatrixFromVectors;907;-2748.884,2167.934;Inherit;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.LerpOp;977;2814.256,-1363.436;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1169;-435.7715,-6650.138;Inherit;False;Constant;_Float148;Float 148;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1009;253.5946,-5130.967;Inherit;False;1007;pointlight;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;995;-452.2612,-4899.6;Inherit;False;Property;_Vector34;假点光坐标;151;0;Create;False;0;0;0;False;1;Sub(g12);False;0,0,0,0;-0.15,1.8,-0.41,0.4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;341;1756.448,-2649.884;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;1064;2233.396,-5119.765;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;909;-2500.665,2129.259;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;332;1219.361,-2577.343;Inherit;False;126;depthfade;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;424;2488.58,-820.4872;Inherit;False;Property;_Float48;折射开关;131;0;Create;False;0;0;0;True;1;SubToggle(g6, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;783;-1532.768,2168.542;Inherit;False;Property;_Float86;折射贴图y轴Clamp;134;0;Create;False;0;0;0;True;1;SubToggle(g6, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-3183.987,208.9487;Inherit;False;Property;_Float17;亮边宽度;84;0;Create;False;0;0;0;False;1;Sub(g3);False;0;0;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1190;2009.387,-5870.713;Inherit;False;0;1070;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;131;2054.327,-1237.012;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;1172;-204.0067,-6601.43;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;427;-8382.333,-2040.575;Inherit;False;Property;_Depthfade_Group1;Depthfade;16;0;Create;False;0;0;0;True;1;Main(g9);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;465;-8073.247,-2002.308;Inherit;False;Property;_Maintex_Group1;颜色混合;43;0;Create;False;0;0;0;True;1;Main(g11);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TransformPositionNode;1000;-401.8653,-4688.542;Inherit;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1088;-8062.813,-2179.41;Inherit;False;Property;_Maintex_Group4;Flowmap;109;0;Create;False;0;0;0;True;1;Main(g14);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;972;2475.927,-1415.218;Inherit;False;971;lit;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-8077.943,-1574.899;Inherit;False;Property;_Ztestmode;深度测试;3;1;[Enum];Create;False;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;4;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GrabScreenPosition;202;-998.173,2010.73;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;185;-683.3252,2113.102;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;973;2401.756,-1538.548;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-8071.956,-1655.507;Inherit;False;Property;_Float4;深度写入;2;1;[Toggle];Create;False;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1074;3468.689,-5023.653;Inherit;False;matcap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;133;-1574.365,10.60641;Inherit;False;dis_edge;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1145;1125.195,-1076.013;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;969;2571.026,-1646.278;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;760;2048.311,-871.9941;Inherit;False;Property;_Color2;折射颜色;139;1;[HDR];Create;False;0;0;0;False;1;Sub(g6);False;1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;759;2352.261,-935.916;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;1078;2828.481,-1188.409;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SmoothstepOpNode;968;1014.017,-5070.382;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;904;-3186.555,2268.514;Inherit;False;Constant;_Float128;Float 128;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;965;815.1935,-5292.873;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1184;1648.92,-6032.866;Inherit;False;Constant;_Float154;Float 154;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;966;2079.057,-1721.463;Inherit;False;Property;_Color4;暗部颜色;149;1;[HDR];Create;False;0;0;0;False;1;Sub(g12);False;0.490566,0.490566,0.490566,1;0.6132076,0.2690014,0.2690014,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;401;-8390.813,-1934.699;Inherit;False;Property;_Maintex_Group;主贴图;30;0;Create;False;0;0;0;True;1;Main(g1);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;335;1214.294,-2480.179;Inherit;False;334;depthfade_switch;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;199;2060.813,-1023.09;Inherit;False;196;ref;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.DistanceOpNode;1001;584.1044,-4794.33;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;971;1011.76,-5230.709;Inherit;False;lit;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;928;3293.546,-964.2614;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1126;690.8657,-2400.662;Inherit;False;maintexuv;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1072;3306.05,-5064.009;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1069;2782.199,-5226.192;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;428;-8384.165,-2153.328;Inherit;False;Property;_Color_Group2;颜色;9;0;Create;False;0;0;0;True;1;Main(g10);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;419;-8390.636,-1666.76;Inherit;False;Property;_Noise_Group;扰动;89;0;Create;False;0;0;0;True;1;Main(g4);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1080;2580.431,-1072.866;Inherit;False;Property;_Float141;matcap开关;154;0;Create;False;0;0;0;True;1;SubToggle(g13, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1077;2551.344,-1146.412;Inherit;False;1074;matcap;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;997;12.76371,-4736.143;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;409;-8385.255,-1756.505;Inherit;False;Property;_Disolove_Group;溶解;70;0;Create;False;0;0;0;True;1;Main(g3);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1013;42.16917,-4615.699;Inherit;False;Property;_Float138;开启世界坐标;152;0;Create;False;0;0;0;False;1;SubToggle(g12, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;425;-8395.455,-1341.458;Inherit;False;Property;_Custom_Group1;custom控制;165;0;Create;False;0;0;0;True;1;Main(g7);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;576;-2640.736,1954.054;Inherit;False;Polar Coordinates;-1;;102;7dab8e02884cf104ebefaa2e788e4162;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;3;FLOAT;1;False;4;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1146;1009.497,-762.8212;Inherit;False;Property;_Float145;双色菲尼尔;25;0;Create;False;0;0;0;False;1;SubToggle(g8, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;196;-344.1315,2114.849;Inherit;False;ref;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;182;3737.324,-576.8052;Inherit;False;181;vertexoffset;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;426;-8391.188,-1231.882;Inherit;False;Property;_Fresnel_Group2;菲尼尔;23;0;Create;False;0;0;0;True;1;Main(g8);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;1185;1583.835,-5698.111;Inherit;False;Property;_Vector12;法线流动&斜切;158;0;Create;False;0;0;0;False;1;Sub(g13);False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;1012;323.3149,-4759.331;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;420;-8383.59,-1562.18;Inherit;False;Property;_Vertex_Group;顶点偏移;112;0;Create;False;0;0;0;True;1;Main(g5);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;191;-1077.867,2646.354;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;404;-8387.01,-1846.811;Inherit;False;Property;_Mask_Group;遮罩;53;0;Create;False;0;0;0;True;1;Main(g2);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;134;1667.987,-779.3342;Inherit;False;133;dis_edge;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1171;-474.0176,-6372.938;Inherit;False;Constant;_Float150;Float 150;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1135;924.0327,-930.0003;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;1191;2257.306,-5681.712;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;381;-801.0881,-1354.992;Inherit;False;Property;_Float40;颜色混合贴图旋转;48;0;Create;False;0;0;0;False;1;Sub(g11);False;0;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1076;3039.843,-1276.661;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1149;-253.004,-5093.876;Inherit;False;Property;_Float146;光照法线强度;145;0;Create;False;0;0;0;False;1;Sub(g12);False;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;903;-3165.06,2176.704;Inherit;False;Constant;_Float127;Float 127;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;767;283.7303,-1466.326;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;188;-1789.108,2149.545;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector3Node;905;-3186.874,2348.734;Inherit;False;Constant;_Vector30;Vector 30;138;0;Create;True;0;0;0;False;0;False;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.PiNode;590;-1685.244,2354.179;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1147;-69.06346,-5216.187;Inherit;True;Property;_normallight;法线;143;0;Create;False;0;0;0;False;1;Sub(g12);False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;765;291.6302,-1744.726;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;1177;477.0487,-5970.574;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1183;1690.978,-6278.385;Inherit;False;Constant;_Float153;Float 153;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;581;-3147.44,2700.61;Inherit;False;Property;_Vector21;折射流动&斜切;138;0;Create;False;0;0;0;False;1;Sub(g6);False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenColorNode;183;-539.8561,2108.272;Inherit;False;Global;_GrabScreen0;Grab Screen 0;1;0;Create;True;0;0;0;False;0;False;Object;-1;False;False;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;610;153.4854,-1586.689;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;1193;2629.631,-5736.188;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;580;-2763.697,2690.697;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1168;-503.6626,-6267.252;Inherit;False;Constant;_Float147;Float 147;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;979;-8073.319,-1928.804;Inherit;False;Property;_Maintex_Group2;假光照;141;0;Create;False;0;0;0;True;1;Main(g12);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1070;1921.106,-5103.755;Inherit;True;Property;_normal;法线;157;0;Create;False;0;0;0;False;1;Sub(g13);False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;967;2372.539,-1686.813;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;234;-766.4282,-1163.969;Inherit;False;231;Gradienttex;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;964;826.4155,-5089.527;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1063;2957.27,-5163.322;Inherit;True;Property;_matcap;matcap(没有主贴图的话改成黑色）;155;0;Create;False;0;0;0;False;1;Sub(g13);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-8090.629,-1763.14;Inherit;False;Property;_Float1;材质模式;0;1;[Enum];Create;False;0;2;blend;10;add;1;0;True;0;False;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;190;-1183.866,2203.28;Inherit;True;Property;_reftex; 折射贴图（法线）;132;0;Create;False;0;0;0;False;1;Sub(g6);False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1081;-8079.145,-1853.214;Inherit;False;Property;_Maintex_Group3;Matcap;153;0;Create;False;0;0;0;True;1;Main(g13);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;1180;-568.7476,-5932.497;Inherit;False;Property;_Vector10;法线流动&斜切;144;0;Create;False;0;0;0;False;1;Sub(g12);False;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;906;-2929.735,2064.001;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClipNode;671;3197.834,-482.4088;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;908;-2912.077,2170.487;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;1438.342,-1240.445;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1073;3045.05,-4915.009;Inherit;False;Property;_Float140;matcap强度;156;0;Create;False;0;0;0;False;1;Sub(g13);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1182;1678.565,-6138.552;Inherit;False;Constant;_Float152;Float 152;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1102;-8058.011,-2287.211;Inherit;False;Property;_Maintex_Group5;视差;160;0;Create;False;0;0;0;True;1;Main(g15);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;591;-1991.792,2336.677;Inherit;False;Property;_Float59;折射贴图旋转;136;0;Create;False;0;0;0;False;1;Sub(g6);False;1;0;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;978;2607.089,-1293.218;Inherit;False;Property;_Float134;假光照开关;142;0;Create;False;0;0;0;True;1;SubToggle(g12, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;976;1900.712,-1560.37;Inherit;False;Property;_Color5;亮部颜色;148;1;[HDR];Create;False;0;0;0;False;1;Sub(g12);False;1,1,1,1;0.6132076,0.2690014,0.2690014,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;329;2152.206,-1987.192;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;653;-1144.161,1993.392;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;201;-1380.826,2430.654;Inherit;False;Constant;_Float26;Float 26;43;0;Create;True;0;0;0;False;0;False;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1170;-461.6045,-6512.771;Inherit;False;Constant;_Float149;Float 149;138;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;94;2427.237,-664.6131;Inherit;False;Property;_Float14;整体颜色强度;11;0;Create;False;0;0;0;False;1;Sub(g10);False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;132;1705.467,-1025.106;Inherit;False;Property;_Color1;亮边颜色;85;1;[HDR];Create;False;0;0;0;False;1;Sub(g3);False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;612;-123.2411,-1760.983;Inherit;False;Property;_Float63;颜色混合贴图x轴Clamp;45;0;Create;False;0;0;0;True;1;SubToggle(g11, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;232;-755.0861,-1028.66;Inherit;False;70;noise;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;600;1819.274,-2122.513;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-8072.098,-1379.883;Inherit;False;Property;_Float2;双面模式;1;1;[Enum];Create;False;0;0;1;UnityEngine.Rendering.CullMode;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;595;-8082.98,-1300.832;Inherit;False;Property;_Ztestmode1;stencil_comp;5;1;[Enum];Create;False;0;0;1;UnityEngine.Rendering.CompareFunction;True;0;False;0;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1071;1719.68,-4969.763;Inherit;False;Property;_Float18;法线强度;159;0;Create;False;0;0;0;False;1;Sub(g13);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;596;-8085.98,-1205.832;Inherit;False;Property;_Ztestmode2;stencil_pass;6;1;[Enum];Create;False;0;0;1;UnityEngine.Rendering.StencilOp;True;0;False;0;4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;597;-8087.689,-1123.75;Inherit;False;Property;_Float46;stencil_reference;7;0;Create;False;0;0;0;True;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;611;118.1047,-1420.927;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;233;-783.6522,-910.5103;Inherit;False;67;noise_intensity_main;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;601;1389.232,-1908.883;Inherit;False;Property;_Float61;切换混合模式（默认lerp，勾上multiply）;51;0;Create;False;0;0;0;True;1;SubToggle(g11, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1181;1716.811,-6415.752;Inherit;False;Constant;_Float151;Float 151;138;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;357;188.4027,-654.0822;Inherit;False;Property;_Color3;颜色2;13;1;[HDR];Create;False;0;0;0;False;1;Sub(g10);False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;195;-1641.269,2795.659;Inherit;False;Property;_Float24;custom2z控制折射;172;0;Create;False;0;0;0;False;1;SubToggle(g7, _);False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1195;4241.351,-1035.048;Float;False;True;-1;2;LWGUI.LWGUI;0;3;Hotwater/2023/URPAll_GUI_0718;2992e84f91cbeb14eab234972e07ea9d;True;Forward;0;1;Forward;8;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;True;True;0;True;22;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;2;0;True;True;2;5;False;-1;10;True;13;1;1;False;-1;10;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;True;0;True;598;False;False;False;False;False;False;True;True;True;255;True;597;255;False;-1;255;False;-1;7;True;595;1;True;595;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;2;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;LightMode=UniversalForward;False;0;Hidden/InternalErrorShader;0;0;Standard;22;Surface;1;  Blend;0;Two Sided;1;Cast Shadows;0;  Use Shadow Threshold;0;Receive Shadows;0;GPU Instancing;1;LOD CrossFade;0;Built-in Fog;0;DOTS Instancing;0;Meta Pass;0;Extra Pre Pass;0;Tessellation;0;  Phong;0;  Strength;0.5,False,-1;  Type;0;  Tess;16,False,-1;  Min;10,False,-1;  Max;25,False,-1;  Edge Length;16,False,-1;  Max Displacement;25,False,-1;Vertex Position,InvertActionOnDeselection;1;0;5;False;True;False;True;False;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1197;4241.351,-1035.048;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;False;False;True;False;False;False;False;0;False;-1;False;False;False;False;False;False;False;False;False;True;1;False;-1;False;False;True;1;LightMode=DepthOnly;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1198;4241.351,-1035.048;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1196;4241.351,-1035.048;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;-1;True;3;False;-1;False;True;1;LightMode=ShadowCaster;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1194;4241.351,-1035.048;Float;False;False;-1;2;UnityEditor.ShaderGraph.PBRMasterGUI;0;1;New Amplify Shader;2992e84f91cbeb14eab234972e07ea9d;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;0;0;False;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;-1;False;True;True;True;True;True;0;False;-1;False;False;False;False;False;False;False;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;0;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
WireConnection;930;0;929;0
WireConnection;878;0;529;4
WireConnection;878;1;873;0
WireConnection;878;2;874;0
WireConnection;876;0;871;0
WireConnection;876;1;529;3
WireConnection;876;2;872;0
WireConnection;877;0;876;0
WireConnection;877;1;878;0
WireConnection;877;2;875;0
WireConnection;535;3;528;1
WireConnection;535;4;528;2
WireConnection;865;0;684;4
WireConnection;865;1;862;0
WireConnection;865;2;861;0
WireConnection;941;0;51;0
WireConnection;941;1;943;0
WireConnection;941;2;942;0
WireConnection;866;0;863;0
WireConnection;866;1;684;3
WireConnection;866;2;864;0
WireConnection;880;0;535;0
WireConnection;880;1;877;0
WireConnection;868;0;866;0
WireConnection;868;1;865;0
WireConnection;868;2;867;0
WireConnection;531;0;528;3
WireConnection;531;1;528;4
WireConnection;879;0;941;0
WireConnection;879;1;877;0
WireConnection;938;0;680;0
WireConnection;938;1;940;0
WireConnection;938;2;939;0
WireConnection;682;3;676;1
WireConnection;682;4;676;2
WireConnection;869;0;938;0
WireConnection;869;1;868;0
WireConnection;870;0;682;0
WireConnection;870;1;868;0
WireConnection;538;0;880;0
WireConnection;538;2;531;0
WireConnection;679;0;676;3
WireConnection;679;1;676;4
WireConnection;536;0;879;0
WireConnection;536;1;531;0
WireConnection;683;0;869;0
WireConnection;683;1;679;0
WireConnection;694;0;870;0
WireConnection;694;2;679;0
WireConnection;530;0;529;1
WireConnection;530;1;529;2
WireConnection;539;0;536;0
WireConnection;539;1;538;0
WireConnection;539;2;540;0
WireConnection;687;0;684;1
WireConnection;687;1;684;2
WireConnection;688;0;683;0
WireConnection;688;1;694;0
WireConnection;688;2;685;0
WireConnection;53;0;539;0
WireConnection;53;2;530;0
WireConnection;394;0;393;0
WireConnection;695;0;696;0
WireConnection;395;0;53;0
WireConnection;395;2;394;0
WireConnection;697;0;688;0
WireConnection;697;2;687;0
WireConnection;638;0;395;0
WireConnection;698;0;697;0
WireConnection;698;2;695;0
WireConnection;639;0;638;1
WireConnection;689;0;698;0
WireConnection;640;0;638;0
WireConnection;690;0;689;0
WireConnection;778;0;638;0
WireConnection;778;1;640;0
WireConnection;778;2;643;0
WireConnection;780;0;638;1
WireConnection;780;1;639;0
WireConnection;780;2;779;0
WireConnection;691;0;689;1
WireConnection;776;0;689;0
WireConnection;776;1;691;0
WireConnection;776;2;777;0
WireConnection;641;0;778;0
WireConnection;641;1;780;0
WireConnection;775;0;689;0
WireConnection;775;1;690;0
WireConnection;775;2;692;0
WireConnection;1131;0;431;1
WireConnection;1131;1;431;2
WireConnection;1130;0;431;3
WireConnection;1130;1;431;4
WireConnection;1132;0;1128;1
WireConnection;1132;1;1128;2
WireConnection;50;1;641;0
WireConnection;799;0;796;0
WireConnection;799;1;439;3
WireConnection;799;2;798;0
WireConnection;803;0;439;4
WireConnection;803;1;802;0
WireConnection;803;2;801;0
WireConnection;693;0;775;0
WireConnection;693;1;776;0
WireConnection;1133;0;1132;0
WireConnection;1133;1;1131;0
WireConnection;1133;2;1130;0
WireConnection;923;0;50;1
WireConnection;923;1;924;1
WireConnection;923;2;924;2
WireConnection;923;3;924;3
WireConnection;923;4;924;4
WireConnection;1127;0;35;0
WireConnection;1127;1;1133;0
WireConnection;1127;2;1134;0
WireConnection;443;3;431;1
WireConnection;443;4;431;2
WireConnection;811;0;500;4
WireConnection;811;1;809;0
WireConnection;811;2;807;0
WireConnection;810;0;814;0
WireConnection;810;1;500;3
WireConnection;810;2;808;0
WireConnection;564;1;693;0
WireConnection;433;0;431;3
WireConnection;433;1;431;4
WireConnection;42;0;39;1
WireConnection;42;1;39;2
WireConnection;795;0;799;0
WireConnection;795;1;803;0
WireConnection;795;2;804;0
WireConnection;506;3;499;1
WireConnection;506;4;499;2
WireConnection;793;0;1127;0
WireConnection;793;1;795;0
WireConnection;567;0;564;1
WireConnection;567;1;923;0
WireConnection;952;0;57;0
WireConnection;952;1;953;0
WireConnection;952;2;951;0
WireConnection;813;0;810;0
WireConnection;813;1;811;0
WireConnection;813;2;812;0
WireConnection;59;0;433;0
WireConnection;59;1;42;0
WireConnection;59;2;60;0
WireConnection;700;0;564;1
WireConnection;700;1;923;0
WireConnection;449;0;433;0
WireConnection;449;1;42;0
WireConnection;449;2;60;0
WireConnection;806;0;443;0
WireConnection;806;1;795;0
WireConnection;701;0;567;0
WireConnection;701;1;700;0
WireConnection;701;2;703;0
WireConnection;732;0;731;0
WireConnection;43;0;793;0
WireConnection;43;1;59;0
WireConnection;502;0;499;3
WireConnection;502;1;499;4
WireConnection;816;0;506;0
WireConnection;816;1;813;0
WireConnection;446;0;806;0
WireConnection;446;2;449;0
WireConnection;815;0;952;0
WireConnection;815;1;813;0
WireConnection;509;0;815;0
WireConnection;509;1;502;0
WireConnection;733;0;732;0
WireConnection;70;0;701;0
WireConnection;440;0;439;1
WireConnection;440;1;439;2
WireConnection;507;0;816;0
WireConnection;507;2;502;0
WireConnection;444;0;43;0
WireConnection;444;1;446;0
WireConnection;444;2;445;0
WireConnection;311;0;310;0
WireConnection;242;0;241;1
WireConnection;242;1;241;2
WireConnection;511;0;509;0
WireConnection;511;1;507;0
WireConnection;511;2;510;0
WireConnection;501;0;500;1
WireConnection;501;1;500;2
WireConnection;316;0;305;0
WireConnection;36;0;444;0
WireConnection;36;2;440;0
WireConnection;58;0;511;0
WireConnection;58;2;501;0
WireConnection;161;0;36;0
WireConnection;738;0;304;0
WireConnection;738;1;302;0
WireConnection;285;0;242;0
WireConnection;307;0;314;0
WireConnection;307;1;303;2
WireConnection;307;2;317;0
WireConnection;1103;0;1095;0
WireConnection;737;0;58;0
WireConnection;737;1;738;0
WireConnection;833;0;830;0
WireConnection;833;1;484;3
WireConnection;833;2;829;0
WireConnection;834;0;484;4
WireConnection;834;1;831;0
WireConnection;834;2;828;0
WireConnection;309;0;737;0
WireConnection;309;1;306;0
WireConnection;309;2;307;0
WireConnection;824;0;479;4
WireConnection;824;1;821;0
WireConnection;824;2;818;0
WireConnection;823;0;820;0
WireConnection;823;1;479;3
WireConnection;823;2;819;0
WireConnection;1092;0;1121;0
WireConnection;1092;1;1094;0
WireConnection;1092;2;1103;0
WireConnection;1092;3;1096;0
WireConnection;1092;4;1104;0
WireConnection;360;0;55;0
WireConnection;825;0;823;0
WireConnection;825;1;824;0
WireConnection;825;2;822;0
WireConnection;931;0;77;0
WireConnection;931;1;932;0
WireConnection;931;2;933;0
WireConnection;75;0;74;3
WireConnection;75;1;74;4
WireConnection;92;0;309;0
WireConnection;497;3;483;1
WireConnection;497;4;483;2
WireConnection;477;3;478;1
WireConnection;477;4;478;2
WireConnection;67;0;360;0
WireConnection;1097;0;1092;0
WireConnection;835;0;833;0
WireConnection;835;1;834;0
WireConnection;835;2;832;0
WireConnection;934;0;217;0
WireConnection;934;1;936;0
WireConnection;934;2;935;0
WireConnection;955;0;418;0
WireConnection;955;1;956;0
WireConnection;955;2;954;0
WireConnection;481;0;478;3
WireConnection;481;1;478;4
WireConnection;486;0;483;3
WireConnection;486;1;483;4
WireConnection;474;0;481;0
WireConnection;474;1;75;0
WireConnection;474;2;73;0
WireConnection;735;0;734;0
WireConnection;385;0;384;0
WireConnection;827;0;477;0
WireConnection;827;1;825;0
WireConnection;837;0;497;0
WireConnection;837;1;835;0
WireConnection;836;0;934;0
WireConnection;836;1;835;0
WireConnection;826;0;931;0
WireConnection;826;1;825;0
WireConnection;571;1;955;0
WireConnection;471;0;481;0
WireConnection;471;1;75;0
WireConnection;471;2;73;0
WireConnection;472;0;827;0
WireConnection;472;2;471;0
WireConnection;736;0;735;0
WireConnection;386;0;93;0
WireConnection;386;2;385;0
WireConnection;491;0;836;0
WireConnection;491;1;486;0
WireConnection;496;0;837;0
WireConnection;496;2;486;0
WireConnection;1099;0;162;0
WireConnection;1099;1;1100;0
WireConnection;1099;2;1101;0
WireConnection;353;0;71;0
WireConnection;353;1;72;0
WireConnection;416;0;415;0
WireConnection;568;0;955;0
WireConnection;568;1;571;0
WireConnection;568;2;510;0
WireConnection;469;0;826;0
WireConnection;469;1;474;0
WireConnection;897;0;555;4
WireConnection;897;1;892;0
WireConnection;897;2;893;0
WireConnection;1017;0;1015;1
WireConnection;1017;1;1015;2
WireConnection;1017;2;1015;3
WireConnection;635;0;386;0
WireConnection;417;0;568;0
WireConnection;417;2;416;0
WireConnection;485;0;484;1
WireConnection;485;1;484;2
WireConnection;480;0;479;1
WireConnection;480;1;479;2
WireConnection;895;0;890;0
WireConnection;895;1;555;3
WireConnection;895;2;891;0
WireConnection;495;0;491;0
WireConnection;495;1;496;0
WireConnection;495;2;494;0
WireConnection;467;0;469;0
WireConnection;467;1;472;0
WireConnection;467;2;468;0
WireConnection;354;0;1099;0
WireConnection;354;1;353;0
WireConnection;99;0;313;0
WireConnection;99;1;100;2
WireConnection;99;2;318;0
WireConnection;322;0;321;0
WireConnection;322;1;323;0
WireConnection;79;0;467;0
WireConnection;79;2;480;0
WireConnection;412;1;417;0
WireConnection;633;0;635;1
WireConnection;1035;0;1017;0
WireConnection;1035;1;1027;0
WireConnection;216;0;495;0
WireConnection;216;2;485;0
WireConnection;949;0;173;0
WireConnection;949;1;950;0
WireConnection;949;2;948;0
WireConnection;378;0;380;0
WireConnection;896;0;895;0
WireConnection;896;1;897;0
WireConnection;896;2;894;0
WireConnection;632;0;635;0
WireConnection;283;0;354;0
WireConnection;283;1;284;0
WireConnection;283;2;99;0
WireConnection;898;0;949;0
WireConnection;898;1;896;0
WireConnection;388;0;387;0
WireConnection;391;0;390;0
WireConnection;886;0;881;0
WireConnection;886;1;716;3
WireConnection;886;2;882;0
WireConnection;784;0;635;0
WireConnection;784;1;632;0
WireConnection;784;2;634;0
WireConnection;549;3;544;1
WireConnection;549;4;544;2
WireConnection;319;0;79;0
WireConnection;319;1;322;0
WireConnection;786;0;635;1
WireConnection;786;1;633;0
WireConnection;786;2;785;0
WireConnection;888;0;716;4
WireConnection;888;1;883;0
WireConnection;888;2;884;0
WireConnection;377;0;283;0
WireConnection;377;2;378;0
WireConnection;320;0;322;0
WireConnection;320;1;216;0
WireConnection;1057;0;412;1
WireConnection;1057;1;1035;0
WireConnection;1057;2;1059;0
WireConnection;631;0;784;0
WireConnection;631;1;786;0
WireConnection;1062;0;918;0
WireConnection;946;0;707;0
WireConnection;946;1;947;0
WireConnection;946;2;945;0
WireConnection;900;0;549;0
WireConnection;900;1;898;0
WireConnection;389;0;320;0
WireConnection;389;2;388;0
WireConnection;546;0;544;3
WireConnection;546;1;544;4
WireConnection;603;0;377;0
WireConnection;712;3;706;1
WireConnection;712;4;706;2
WireConnection;277;0;1057;0
WireConnection;887;0;886;0
WireConnection;887;1;888;0
WireConnection;887;2;885;0
WireConnection;392;0;319;0
WireConnection;392;2;391;0
WireConnection;617;0;392;0
WireConnection;915;0;912;4
WireConnection;623;0;389;0
WireConnection;710;0;706;3
WireConnection;710;1;706;4
WireConnection;889;0;946;0
WireConnection;889;1;887;0
WireConnection;554;0;900;0
WireConnection;554;2;546;0
WireConnection;605;0;603;1
WireConnection;62;0;29;0
WireConnection;62;1;49;1
WireConnection;62;2;61;0
WireConnection;23;1;631;0
WireConnection;899;0;712;0
WireConnection;899;1;887;0
WireConnection;1060;0;918;0
WireConnection;1060;1;1062;0
WireConnection;1060;2;1059;0
WireConnection;604;0;603;0
WireConnection;551;0;898;0
WireConnection;551;1;546;0
WireConnection;913;0;62;0
WireConnection;913;1;915;0
WireConnection;913;2;914;0
WireConnection;624;0;623;0
WireConnection;351;0;136;0
WireConnection;351;1;352;0
WireConnection;711;0;889;0
WireConnection;711;1;710;0
WireConnection;625;0;623;1
WireConnection;715;0;899;0
WireConnection;715;2;710;0
WireConnection;557;0;555;1
WireConnection;557;1;555;2
WireConnection;556;0;551;0
WireConnection;556;1;554;0
WireConnection;556;2;552;0
WireConnection;618;0;617;0
WireConnection;607;0;603;0
WireConnection;607;1;604;0
WireConnection;607;2;608;0
WireConnection;619;0;617;1
WireConnection;916;0;23;1
WireConnection;916;1;281;0
WireConnection;916;2;1060;0
WireConnection;764;0;603;1
WireConnection;764;1;605;0
WireConnection;764;2;763;0
WireConnection;773;0;623;1
WireConnection;773;1;625;0
WireConnection;773;2;774;0
WireConnection;168;0;556;0
WireConnection;168;2;557;0
WireConnection;719;0;716;1
WireConnection;719;1;716;2
WireConnection;771;0;617;1
WireConnection;771;1;619;0
WireConnection;771;2;770;0
WireConnection;397;0;396;0
WireConnection;139;0;351;0
WireConnection;139;4;137;0
WireConnection;139;2;135;0
WireConnection;139;3;138;0
WireConnection;97;1;98;0
WireConnection;97;0;96;0
WireConnection;334;0;333;0
WireConnection;24;0;916;0
WireConnection;24;1;25;0
WireConnection;772;0;623;0
WireConnection;772;1;624;0
WireConnection;772;2;626;0
WireConnection;769;0;617;0
WireConnection;769;1;618;0
WireConnection;769;2;620;0
WireConnection;606;0;607;0
WireConnection;606;1;764;0
WireConnection;661;0;916;0
WireConnection;30;0;913;0
WireConnection;30;1;31;0
WireConnection;728;0;711;0
WireConnection;728;1;715;0
WireConnection;728;2;714;0
WireConnection;140;0;139;0
WireConnection;1090;0;33;0
WireConnection;1090;1;1089;3
WireConnection;1090;2;1091;0
WireConnection;754;2;752;0
WireConnection;754;0;756;0
WireConnection;754;1;753;0
WireConnection;327;0;97;0
WireConnection;398;0;168;0
WireConnection;398;2;397;0
WireConnection;1;1;606;0
WireConnection;26;0;24;0
WireConnection;26;1;30;0
WireConnection;729;0;718;0
WireConnection;622;0;772;0
WireConnection;622;1;773;0
WireConnection;616;0;769;0
WireConnection;616;1;771;0
WireConnection;725;0;728;0
WireConnection;725;2;719;0
WireConnection;45;0;26;0
WireConnection;218;1;622;0
WireConnection;726;0;725;0
WireConnection;726;2;729;0
WireConnection;336;0;97;0
WireConnection;336;1;327;0
WireConnection;336;2;337;0
WireConnection;34;0;1090;0
WireConnection;130;0;1053;0
WireConnection;755;0;754;0
WireConnection;141;0;140;0
WireConnection;8;1;616;0
WireConnection;402;0;1;4
WireConnection;402;1;1;1
WireConnection;402;2;403;0
WireConnection;644;0;398;0
WireConnection;1199;0;402;0
WireConnection;144;0;140;0
WireConnection;144;1;141;0
WireConnection;144;2;142;0
WireConnection;406;0;8;4
WireConnection;406;1;8;1
WireConnection;406;2;405;0
WireConnection;646;0;644;0
WireConnection;720;0;726;0
WireConnection;757;0;755;0
WireConnection;757;1;336;0
WireConnection;105;0;913;0
WireConnection;105;1;130;0
WireConnection;32;0;45;0
WireConnection;32;1;1090;0
WireConnection;32;2;34;0
WireConnection;407;0;218;4
WireConnection;407;1;218;1
WireConnection;407;2;408;0
WireConnection;645;0;644;1
WireConnection;372;0;1199;0
WireConnection;372;1;365;0
WireConnection;122;0;32;0
WireConnection;790;0;644;0
WireConnection;790;1;646;0
WireConnection;790;2;649;0
WireConnection;722;0;720;1
WireConnection;147;0;144;0
WireConnection;126;0;757;0
WireConnection;721;0;720;0
WireConnection;124;0;105;0
WireConnection;220;0;406;0
WireConnection;220;1;407;0
WireConnection;791;0;644;1
WireConnection;791;1;645;0
WireConnection;791;2;792;0
WireConnection;647;0;790;0
WireConnection;647;1;791;0
WireConnection;82;0;220;0
WireConnection;787;0;720;0
WireConnection;787;1;721;0
WireConnection;787;2;727;0
WireConnection;789;0;720;1
WireConnection;789;1;722;0
WireConnection;789;2;788;0
WireConnection;373;0;372;0
WireConnection;373;1;370;0
WireConnection;374;0;402;0
WireConnection;374;1;373;0
WireConnection;374;2;367;0
WireConnection;413;0;123;0
WireConnection;413;1;125;0
WireConnection;413;2;414;0
WireConnection;338;0;128;0
WireConnection;338;2;340;0
WireConnection;169;1;647;0
WireConnection;723;0;787;0
WireConnection;723;1;789;0
WireConnection;347;0;209;0
WireConnection;347;1;150;0
WireConnection;347;2;350;0
WireConnection;921;0;169;1
WireConnection;921;1;922;1
WireConnection;921;2;922;2
WireConnection;921;3;922;3
WireConnection;921;4;922;4
WireConnection;176;0;178;0
WireConnection;176;1;167;4
WireConnection;176;2;179;0
WireConnection;705;1;723;0
WireConnection;993;0;994;0
WireConnection;993;1;172;0
WireConnection;993;2;990;0
WireConnection;6;0;374;0
WireConnection;6;1;3;4
WireConnection;6;2;4;4
WireConnection;6;3;413;0
WireConnection;6;4;95;0
WireConnection;6;5;338;0
WireConnection;6;6;221;0
WireConnection;6;7;347;0
WireConnection;171;0;921;0
WireConnection;171;1;993;0
WireConnection;171;2;175;0
WireConnection;171;3;176;0
WireConnection;171;4;705;1
WireConnection;602;0;6;0
WireConnection;181;0;171;0
WireConnection;656;0;6;0
WireConnection;656;1;602;0
WireConnection;656;2;657;0
WireConnection;1187;0;1181;0
WireConnection;1187;1;1185;3
WireConnection;1187;2;1183;0
WireConnection;599;0;1;0
WireConnection;599;1;212;0
WireConnection;651;0;650;1
WireConnection;422;0;1076;0
WireConnection;422;1;759;0
WireConnection;422;2;424;0
WireConnection;589;0;188;0
WireConnection;589;2;590;0
WireConnection;1007;0;1001;0
WireConnection;652;0;650;0
WireConnection;1173;0;1180;4
WireConnection;1173;1;1171;0
WireConnection;1173;2;1168;0
WireConnection;107;0;109;0
WireConnection;107;1;130;0
WireConnection;193;0;192;0
WireConnection;193;1;194;3
WireConnection;193;2;195;0
WireConnection;1068;0;1067;0
WireConnection;852;0;439;4
WireConnection;852;1;849;0
WireConnection;852;2;846;0
WireConnection;1176;0;1175;0
WireConnection;1176;1;1179;0
WireConnection;1189;0;1187;0
WireConnection;1189;1;1186;0
WireConnection;1189;2;1188;0
WireConnection;582;0;909;0
WireConnection;582;1;579;0
WireConnection;1175;0;1172;0
WireConnection;1175;1;1173;0
WireConnection;1175;2;1174;0
WireConnection;584;0;910;0
WireConnection;584;2;579;0
WireConnection;910;1;907;0
WireConnection;579;0;575;3
WireConnection;579;1;575;4
WireConnection;383;0;235;0
WireConnection;383;2;382;0
WireConnection;231;0;229;0
WireConnection;1186;0;1185;4
WireConnection;1186;1;1182;0
WireConnection;1186;2;1184;0
WireConnection;235;0;234;0
WireConnection;235;1;232;0
WireConnection;235;2;233;0
WireConnection;1067;0;1066;0
WireConnection;382;0;381;0
WireConnection;585;0;582;0
WireConnection;585;1;584;0
WireConnection;585;2;586;0
WireConnection;609;0;383;0
WireConnection;108;0;105;0
WireConnection;108;1;107;0
WireConnection;1192;0;1189;0
WireConnection;1192;1;1190;0
WireConnection;229;0;451;0
WireConnection;229;2;464;0
WireConnection;996;0;995;1
WireConnection;996;1;995;2
WireConnection;996;2;995;3
WireConnection;1008;0;960;0
WireConnection;1008;1;1009;0
WireConnection;1008;2;1011;0
WireConnection;212;1;768;0
WireConnection;1178;0;1180;1
WireConnection;1178;1;1180;2
WireConnection;345;0;330;0
WireConnection;345;1;346;0
WireConnection;464;0;463;1
WireConnection;464;1;463;2
WireConnection;961;0;959;0
WireConnection;458;0;854;0
WireConnection;458;1;457;0
WireConnection;855;0;460;0
WireConnection;855;1;853;0
WireConnection;963;0;1008;0
WireConnection;451;0;453;0
WireConnection;451;1;461;0
WireConnection;451;2;452;0
WireConnection;454;0;455;0
WireConnection;454;1;456;0
WireConnection;330;1;332;0
WireConnection;330;2;335;0
WireConnection;457;0;459;3
WireConnection;457;1;459;4
WireConnection;461;0;855;0
WireConnection;461;2;457;0
WireConnection;460;1;226;0
WireConnection;460;3;459;1
WireConnection;460;4;459;2
WireConnection;782;0;650;1
WireConnection;782;1;651;0
WireConnection;782;2;783;0
WireConnection;359;0;4;0
WireConnection;359;1;357;0
WireConnection;359;2;358;0
WireConnection;650;0;589;0
WireConnection;781;0;650;0
WireConnection;781;1;652;0
WireConnection;781;2;655;0
WireConnection;960;0;958;0
WireConnection;960;1;957;0
WireConnection;456;0;459;2
WireConnection;109;0;913;0
WireConnection;109;1;106;0
WireConnection;455;0;459;1
WireConnection;854;0;226;0
WireConnection;854;1;853;0
WireConnection;356;0;4;0
WireConnection;356;1;359;0
WireConnection;211;0;1;0
WireConnection;211;1;212;0
WireConnection;211;2;213;0
WireConnection;851;0;848;0
WireConnection;851;1;439;3
WireConnection;851;2;847;0
WireConnection;1066;0;1065;0
WireConnection;1066;1;1064;0
WireConnection;768;0;765;0
WireConnection;768;1;767;0
WireConnection;453;0;854;0
WireConnection;453;1;454;0
WireConnection;453;2;458;0
WireConnection;853;0;851;0
WireConnection;853;1;852;0
WireConnection;853;2;850;0
WireConnection;957;0;1147;0
WireConnection;907;0;906;0
WireConnection;907;1;908;0
WireConnection;907;2;905;0
WireConnection;977;0;131;0
WireConnection;977;1;969;0
WireConnection;977;2;978;0
WireConnection;341;0;343;0
WireConnection;341;1;345;0
WireConnection;1064;0;1070;0
WireConnection;909;0;186;0
WireConnection;909;1;907;0
WireConnection;131;0;5;0
WireConnection;131;1;132;0
WireConnection;131;2;134;0
WireConnection;1172;0;1169;0
WireConnection;1172;1;1180;3
WireConnection;1172;2;1170;0
WireConnection;185;0;202;0
WireConnection;185;1;190;0
WireConnection;973;0;976;0
WireConnection;973;1;131;0
WireConnection;1074;0;1072;0
WireConnection;133;0;108;0
WireConnection;1145;0;356;0
WireConnection;1145;1;1135;0
WireConnection;1145;2;1146;0
WireConnection;969;0;967;0
WireConnection;969;1;973;0
WireConnection;969;2;972;0
WireConnection;759;0;199;0
WireConnection;759;1;760;0
WireConnection;1078;1;1077;0
WireConnection;1078;2;1080;0
WireConnection;968;0;965;0
WireConnection;968;1;964;0
WireConnection;968;2;962;0
WireConnection;965;0;963;0
WireConnection;965;1;961;0
WireConnection;1001;0;996;0
WireConnection;1001;1;1002;0
WireConnection;971;0;968;0
WireConnection;928;0;1076;0
WireConnection;928;1;94;0
WireConnection;1126;0;606;0
WireConnection;1072;0;1063;0
WireConnection;1072;1;1073;0
WireConnection;1069;0;1068;0
WireConnection;997;0;996;0
WireConnection;997;1;1000;0
WireConnection;576;1;186;0
WireConnection;576;3;575;1
WireConnection;576;4;575;2
WireConnection;196;0;183;0
WireConnection;1012;0;997;0
WireConnection;1012;1;996;0
WireConnection;1012;2;1013;0
WireConnection;191;0;201;0
WireConnection;191;1;193;0
WireConnection;1135;0;356;0
WireConnection;1135;1;1142;0
WireConnection;1135;2;1136;0
WireConnection;1191;0;1185;1
WireConnection;1191;1;1185;2
WireConnection;1076;0;977;0
WireConnection;1076;1;1078;0
WireConnection;767;0;609;1
WireConnection;767;1;611;0
WireConnection;767;2;766;0
WireConnection;188;0;585;0
WireConnection;188;2;580;0
WireConnection;590;0;591;0
WireConnection;1147;1;1177;0
WireConnection;1147;5;1149;0
WireConnection;765;0;609;0
WireConnection;765;1;610;0
WireConnection;765;2;612;0
WireConnection;1177;0;1176;0
WireConnection;1177;2;1178;0
WireConnection;183;0;185;0
WireConnection;610;0;609;0
WireConnection;1193;0;1192;0
WireConnection;1193;2;1191;0
WireConnection;580;0;581;1
WireConnection;580;1;581;2
WireConnection;1070;1;1193;0
WireConnection;1070;5;1071;0
WireConnection;967;0;966;0
WireConnection;967;1;131;0
WireConnection;964;0;962;0
WireConnection;1063;1;1069;0
WireConnection;190;1;653;0
WireConnection;190;5;191;0
WireConnection;906;0;901;0
WireConnection;906;1;581;3
WireConnection;906;2;902;0
WireConnection;671;0;656;0
WireConnection;671;1;672;0
WireConnection;671;2;673;0
WireConnection;908;0;581;4
WireConnection;908;1;903;0
WireConnection;908;2;904;0
WireConnection;5;0;329;0
WireConnection;5;1;3;0
WireConnection;5;2;1145;0
WireConnection;5;3;347;0
WireConnection;329;0;341;0
WireConnection;329;1;600;0
WireConnection;653;0;781;0
WireConnection;653;1;782;0
WireConnection;600;0;211;0
WireConnection;600;1;599;0
WireConnection;600;2;601;0
WireConnection;611;0;609;1
WireConnection;1195;2;928;0
WireConnection;1195;3;671;0
WireConnection;1195;5;182;0
ASEEND*/
//CHKSM=DF85FAE439065691FAFDBC13232E1994DCE3C481